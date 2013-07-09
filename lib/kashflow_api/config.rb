module KashflowApi
    class Config
        attr_accessor :username, :password, :loggers
        
        def initialize
            @loggers = true
        end
        
        def loggers=(i)
          @loggers = i
            HTTPI.log = i
        end
    end
end