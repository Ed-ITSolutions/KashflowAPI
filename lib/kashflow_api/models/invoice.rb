module KashflowApi
    class Invoice < KashflowApi::SoapObject
        def self.find(search)
            result = KashflowApi.api.get_invoice(search)
            self.build_from_soap(result.basic_hash[:envelope][:body][:get_invoice_response][:get_invoice_result])
        end
        
        def customer
            KashflowApi::Customer.find_by_customer_id(self.customerid)
        end
        
        def save
            if @hash["InvoiceDBID"] == "0"
                insert_invoice
            else
                update_invoice
            end
        end
        
        def to_xml
            xml = []
            id_line = ""
            @hash.keys.each do |key|
                if key == "InvoiceDBID"
                    id_line = "<#{key}>#{@hash[key]}</#{key}>" unless @hash[key] == "0"
                else
                    xml.push("<#{key}>#{@hash[key]}</#{key}>")
                end
            end
            [id_line, xml.join].join
        end
        
        private
        
        def blank_object_hash
            { "InvoiceNumber" => "", "InvoiceDate" => "", "DueDate" => "", "CustomerID" => "", "CustomerReference" => "", "InvoiceDBID" => "0" }
        end
        
        def update_invoice
            KashflowApi.api.update_invoice(self)
        end

        def insert_invoice
            KashflowApi.api.insert_invoice(self)
        end
    end
end