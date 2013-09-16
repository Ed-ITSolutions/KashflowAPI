module KashflowApi
  class SoapObject
    include Expects
    
    attr_reader :hash
    
    def initialize(hash = nil)
      expects(hash, Hash) if hash
      @hash = (hash || new_object_hash)
      init_class
    end
    
    def self.inherited(klass)
      KashflowApi.add_soap_object(klass)
    end
    
    def self.all
      result = KashflowApi.api.send("get_#{self::KFObject[:plural]}".to_sym)
      results = []
      result.hash[:envelope][:body]["get_#{self::KFObject[:plural]}_response".to_sym]["get_#{self::KFObject[:plural]}_result".to_sym][self::KFObject[:singular].to_sym].each do |result|
        results.push self.new result
      end
      return results
    end
    
    def self.find(search)
      self.send(find_method, search)
    end
    
    def self.find_method
      "find_by_#{self::Finds.first}".to_sym
    end
    
    def self.define_methods
      self::Finds.each do |find|
        method_name = "find_by_#{find}".to_sym
        result_name = find == self::Finds.first ? "get_#{self::KFObject[:singular]}" : "get_#{self::KFObject[:singular]}_by_#{find}"
        
        self.define_singleton_method(method_name, Proc.new { |search|
          result = KashflowApi.api.send(result_name.to_sym, search)
          hash = result.hash[:envelope][:body]["#{result_name}_response".to_sym]["#{result_name}_result".to_sym]
          return self.new(hash)
        })
      end
    end
    
    def to_xml
        xml = []
        id_line = ""
        @hash.keys.each do |key|
            if key == self.class::XMLKey
                id_line = "<#{key}>#{@hash[key]}</#{key}>" unless @hash[key] == "0"
            else
                xml.push("<#{key}>#{@hash[key]}</#{key}>")
            end
        end
        [id_line, xml.join].join
    end
        
    private
    
    def new_object_hash
      hash = {}
      self.class::Keys.each do |key|
        key = [*key]
        hash[key.first] = (key.last == key.first ? "" : key.last )
      end
      return hash
    end
    
    def init_class
      @hash.keys.each do |key|
        self.class.send(:define_method, key.downcase.to_sym) do
          @hash[key]
        end
        self.class.send(:define_method, "#{key.downcase}=".to_sym) do |set|
          @hash[key] = set
        end
      end
    end
  end
end