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
      #"KashFlow/#{api_call.method}"
      #result = @client.xml_call(api_call.method_sym, api_call)
      result = @client.call(api_call.method_sym, xml: api_call.xml)
      raise "Incorrect username or password" if result.to_hash.first.last[:status_detail] == "Incorrect username or password"
      raise "Your IP Address is not in the access list!" if result.to_hash.first.last[:status_detail] =~ /The IP address of .*? is not in the access list/
      #raise api_call.xml if result.to_hash.first.last[:status] == "NO"
      raise "Kashflow Error: #{result.to_hash.first.last[:status_detail]}" if result.to_hash.first.last[:status] == "NO"
      return result
    end
  end
end