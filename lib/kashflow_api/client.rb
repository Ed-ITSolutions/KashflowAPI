module KashflowApi
    class Client
        def initialize(config)
            @config = config
            @url = "https://securedwebapp.com/api/service.asmx?WSDL"
            
            @client = Savon::Client.new @url
        end
        
        def call(api_call)
            result = @client.request("KashFlow/#{api_call.method}") do |soap|
                soap.xml = api_call.xml
            end
            raise "Incorrect username or password" if result.to_hash.first.last[:status_detail] == "Incorrect username or password"
            raise "Your IP Address is not in the access list!" if result.to_hash.first.last[:status_detail] =~ /The IP address of .*? is not in the access list/
            #raise api_call.xml if result.to_hash.first.last[:status] == "NO"
            raise "Kashflow Error: #{result.to_hash.first.last[:status_detail]}" if result.to_hash.first.last[:status] == "NO"
            return result
        end
        
        def client
            @client
        end
    end
end