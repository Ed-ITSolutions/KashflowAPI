module KashflowApi
    class Config
        attr_accessor :username, :password
        
        def initialize
            @loggers = true
        end
        
        def loggers=(i)
            HTTPI.log = i
            Savon.log = i
        end
    end
end