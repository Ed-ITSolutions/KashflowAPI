module KashflowApi
    class Api        
        def initialize
            unless KashflowApi.config.username && KashflowApi.config.password
               raise "Username and Password required" 
            end
        end
        
        def self.methods
            @methods ||= generate_method_list
        end
        
        # Main Handler
        def method_missing(method, argument = nil)
            methods = KashflowApi.api_methods
            if methods.include?(method)
                KashflowApi::ApiCall.new(method, argument).result
            else
                super
            end
        end
        
        private
        
        def self.generate_method_list
            KashflowApi.client.client.operations
        end
    end
end