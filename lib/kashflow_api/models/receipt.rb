module KashflowApi
  class Receipt < KashflowApi::SoapObject
    Keys = KashflowApi::Invoice::Keys
    
    Finds = KashflowApi::Invoice::Finds
    
    KFObject = { singular: "receipt", plural: "receipts" }
    
    XMLKey = "InvoiceDBID"
    
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