module KashflowApi
  class Client
    include Expects
    
    attr_reader :client
    
    def initialize(config)
      expects config, KashflowApi::Config
      
      @config = config
      @url = "https://securedwebapp.com/api/service.asmx?WSDL"
      @client = Savon.client(wsdl: @url, log: @config.loggers)
    end
    
    def call(api_call)
      result = @client.call(api_call.method_sym, xml: api_call.xml)
      handle_errors(result.to_hash)
      return result
    end
    
    def handle_errors(hash)
      raise "Incorrect username or password" if hash.first.last[:status_detail] == "Incorrect username or password"
      raise "Your IP Address is not in the access list!" if hash.first.last[:status_detail] =~ /The IP address of .*? is not in the access list/
      raise "Kashflow Error: #{result.to_hash.first.last[:status_detail]}" if hash.first.last[:status] == "NO"
    end
  end
end