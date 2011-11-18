module KashflowApi
    class ApiCall
        attr_reader :result, :xml, :method
        
        def initialize(method, argument)
            set_method(method)
            build_xml(argument)
            @result = make_call
        end
        
        private
        
        def xml_header
            "<?xml version=\"1.0\" encoding=\"utf-8\"?>
            <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
            <soap:Body>\n"
        end
        
        def xml_footer
            "</soap:Body>
            </soap:Envelope>"
        end
        
        def set_method(method)
            words = method.to_s.split("_")
            words.map { |word| word.capitalize! }
            @action = words.first.downcase
            @object = words[1].downcase
            words[words.count - 1] = words.last.upcase if words.last == "Id"
            @field = words.last
            @field = "Code" if method == :get_customer || @field == "Balance"
            @method = words.join
        end
        
        def build_xml(argument)
            @xml = xml_header
            @xml += "<#{@method} xmlns=\"KashFlow\">\n"
            @xml += user_details
            @xml += argument_xml(argument)
            @xml += "</#{@method}>\n"
            @xml += xml_footer
        end
        
        def user_details
            "<UserName>#{KashflowApi.config.username}</UserName>
            <Password>#{KashflowApi.config.password}</Password>\n"
        end
        
        def make_call
            KashflowApi.client.call(self)
        end
        
        def argument_xml(argument)
            out = ""
            if argument
                if @action == "get"
                    if @object == "customer" 
                        out = "<Customer#{@field}>#{argument}</Customer#{@field}>"
                    elsif @object == "customers"
                        out = "<#{@field}>#{argument}</#{@field}>"
                    end
                elsif @action == "update" || @action == "insert"
                    if @object == "customer"
                        out = "<custr>#{argument.to_xml}</custr>"
                    end
                elsif @action == "delete"
                    if @object == "customer"
                        out = "<CustomerID>#{argument}</CustomerID>"
                    end
                end
            end
            out
        end
    end
end
