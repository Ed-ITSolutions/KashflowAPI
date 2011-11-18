module KashflowApi
    class SoapObject
        attr_reader :hash
        
        def initialize(hash = nil)
            if hash
                @hash = hash
                build_field_hash
            else
                @hash = blank_object_hash
                build_field_hash
            end
        end
        
        def method_missing(method, set = nil)
            if @fields.keys.include? method
                @hash[@fields[method]]
            elsif method.to_s.scan(/.$/).join == "="
                if @fields.keys.include? method.to_s.gsub(/\=/,'').to_sym
                    @hash[@fields[method.to_s.gsub(/\=/,'').to_sym]] = set
                end
            else
                super
            end
        end
        
        def self.build_from_soap(hash)
            self.new(hash)
        end
        
        private
        
        def build_field_hash
            @fields = {}
            @hash.keys.each do |key|
                @fields[key.downcase.to_sym] = key
            end
        end
    end
end