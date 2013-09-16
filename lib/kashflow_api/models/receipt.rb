module KashflowApi
  class Receipt < KashflowApi::SoapObject
    Keys = KashflowApi::Invoice::Keys
    
    Finds = KashflowApi::Invoice::Finds
    
    KFObject = { singular: "receipt", plural: "receipts" }
    
    XMLKey = "InvoiceDBID"
    
    def self.build_arguments(action, object, field, argument)
      if action == "get"
        expects argument, String
        return "<ReceiptNumber>#{argument}</ReceiptNumber>" if object == "receipt"
      elsif action == "update" || action == "insert"
        expects argument, KashflowApi::Receipt
        return "<ReceiptID>#{argument.receiptid}</ReceiptID><InvLine>#{argument.to_xml}</InvLine>" if field == "Line"
        return "<ReceiptNumber>#{argument.invoicenumber}</ReceiptNumber><InvLine>#{argument.to_xml}</InvLine>" if field == "Number"
        return "<Inv>#{argument.to_xml}</Inv>" if object == "receipt"
      end
    end
    
    def save
      if @hash["InvoiceDBID"] == "0"
        insert_receipt
      else
        update_receipt
      end
    end

    private
            
    def update_receipt
      KashflowApi.api.update_receipt(self)
    end

    def insert_receipt
      KashflowApi.api.insert_receipt(self)
    end
  end
end