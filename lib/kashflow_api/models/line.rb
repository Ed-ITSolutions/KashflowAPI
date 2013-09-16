module KashflowApi
    class Line < KashflowApi::SoapObject
      Keys = [
        "Quantity", "Description", "ChargeType", "VatAmount", "VatRate", "Rate", "ReceiptID", "InvoiceID", "InvoiceNumber", "ReceiptNumber"
      ]
      
      Finds = []
      
      KFObject = {singular: "line", plural: "lines"}
      
      
        def save
            if @hash["ReceiptID"] != ""
                insert_receipt_line
            elsif @hash["InvoiceID"] != ""
                insert_invoice_line
            elsif @hash["InvoiceNumber"] != ""
                insert_invoice_number_line
            elsif @hash["ReceiptNumber"] != ""
                insert_receipt_number_line    
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
        
        def insert_receipt_line
            KashflowApi.api.insert_receipt_line(self)
        end
        
        def insert_invoice_line
            KashflowApi.api.insert_invoice_line(self)
        end
        
        def insert_invoice_number_line
          KashflowApi.api.insert_invoice_line_with_invoice_number(self)
        end
        
        def insert_receipt_number_line
          KashflowApi.api.insert_receipt_line_from_number(self)
        end
    end
end
