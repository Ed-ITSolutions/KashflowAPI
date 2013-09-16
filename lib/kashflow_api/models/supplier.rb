module KashflowApi
  class Supplier < KashflowApi::SoapObject
    Keys = [
      "Code", "Name", "Contact", "Telephone", "Mobile", "Fax", "Email", "Address1", "Address2", "Address3", "Address4", "Postcode", "Website", "VATNumber", "Notes"
    ]
    
    Finds = [ "code", "id" ]
    
    KFObject = { singular: "supplier", plural: "suppliers" }
    
    XMLKey = "SupplierID"
    
    def save
      if @hash["SupplierID"] == "0"
        insert_supplier
      else
        update_supplier
      end 
    end
      
    private
   
    def update_supplier
      KashflowApi.api.update_supplier(self)
    end
        
    def insert_supplier
      KashflowApi.api.insert_supplier(self)
    end
  end
end