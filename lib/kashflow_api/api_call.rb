module KashflowApi
    class ApiCall
        attr_reader :result, :xml, :method, :method_sym
        
        def initialize(method, argument)
            @method_sym = method.to_sym
            set_method(method)
            build_xml(argument)
            return self
        end
        
        def make_call
            KashflowApi.client.call(self)
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
        
        def argument_xml(argument)
          case @object
          when "customer" || "customers"
            return KashflowApi::Customer.build_arguments(@action, @object, @field, argument)
          when "invoice"
            return KashflowApi::Invoice.build_arguments(@action, @object, @field, argument)
          when "quote"
            return KashflowApi::Quote.build_arguments(@action, @object, @field, argument)
          when "receipt"
            return KashflowApi::Receipt.build_arguments(@action, @object, @field, argument)
          when "supplier"
            return KashflowApi::Supplier.build_arguments(@action, @object, @field, argument)
          else
            return ""
          end
        end
    end
end
