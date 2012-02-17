module KashflowApi
    class ApiCall
        attr_reader :result, :xml, :method
        
        def initialize(method, argument)
            set_method(method)
            build_xml(argument)
            raise xml if @raise
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
            @field = "Code" if method == :get_customer || @field == "Balance" || method == :get_supplier
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
                    elsif @object == "quote"
                        out = "<Quote#{@field}>#{argument}</Quote#{@field}>"
                    elsif @object == "supplier"
                        out = "<Supplier#{@field}>#{argument}</Supplier#{@field}>"
                    elsif @object == "receipt"
                        out = "<ReceiptNumber>#{argument}</ReceiptNumber>"
                    elsif @object == "invoice"
                        out = "<InvoiceNumber>#{argument}</InvoiceNumber>"
                    end
                elsif @action == "update" || @action == "insert"
                    if @object == "customer"
                        out = "<custr>#{argument.to_xml}</custr>"
                    elsif @object == "supplier"
                        if @action == "insert"
                            out = "<supl>#{argument.to_xml}</supl>"
                        else
                            out = "<sup>#{argument.to_xml}</sup>"
                        end
                    elsif @object == "receipt"
                        if @field == "Line"
                            out = "<ReceiptID>#{argument.receiptid}</ReceiptID><InvLine>#{argument.to_xml}</InvLine>"
                        else
                            out = "<Inv>#{argument.to_xml}</Inv>"
                        end
                    elsif @object == "invoice"
                        if @field == "Line"
                            out = "<InvoiceID>#{argument.invoiceid}</InvoiceID><InvLine>#{argument.to_xml}</InvLine>"
                        else
                            out = "<Inv>#{argument.to_xml}</Inv>"
                        end
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
