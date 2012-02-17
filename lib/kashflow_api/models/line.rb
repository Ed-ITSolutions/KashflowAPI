module KashflowApi
    class Line < KashflowApi::SoapObject
        def save
            if @hash["ReceiptID"] != ""
                insert_receipt_line
            elsif @hash["InvoiceID"] != ""
                insert_invoice_line
            end
        end
        
        def to_xml
            xml = []
            id_line = ""
            @hash.keys.each do |key|
                if key == "LineID"
                    id_line = "<#{key}>#{@hash[key]}</#{key}>" unless @hash[key] == "0"
                elsif key != "ReceiptID" && key != "InvoiceID" && @hash[key] != ""
                    xml.push("<#{key}>#{@hash[key]}</#{key}>")
                end
            end
            [id_line, xml.join].join
        end
        
        private
        
        def blank_object_hash
            {"Quantity" => "", "Description" => "", "ChargeType" => "", "VatAmount" => "", "VatRate" => "", "Rate" => "", "ReceiptID" => "", "InvoiceID" => "" }
        end
        
        def insert_receipt_line
            KashflowApi.api.insert_receipt_line(self)
        end
        
        def insert_invoice_line
            KashflowApi.api.insert_invoice_line(self)
        end
    end
end
