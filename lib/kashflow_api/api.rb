module KashflowApi
  class Api        
    def initialize
      unless KashflowApi.config.username && KashflowApi.config.password
        raise "Username and Password required" 
      end
      
      init_class
    end
    
    def self.method_list
      @methods ||= generate_method_list
    end
    
    private
    
    def init_class
      KashflowApi.api_methods.each do |method|
        self.class.send(:define_method, method) do |argument = nil| 
          KashflowApi::ApiCall.new(method, argument).make_call
        end
      end
    end
    
    def self.generate_method_list
      KashflowApi.client.client.operations
    end
  end
end