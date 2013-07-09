module KashflowApi
    class Receipt < KashflowApi::SoapObject
            def self.find(search)
                result = KashflowApi.api.get_receipt(search)
                self.build_from_soap(result.hash[:envelope][:body][:get_receipt_response][:get_receipt_result])
            end

            def save
                if @hash["InvoiceDBID"] == "0"
                    insert_receipt
                else
                    update_receipt
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
            
            def update_receipt
                KashflowApi.api.update_receipt(self)
            end

            def insert_receipt
                KashflowApi.api.insert_receipt(self)
            end
    end
end