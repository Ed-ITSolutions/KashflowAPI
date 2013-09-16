module KashflowApi
  class Supplier < KashflowApi::SoapObject
    Keys = [
      "Code", "Name", "Contact", "Telephone", "Mobile", "Fax", "Email", "Address1", "Address2", "Address3", "Address4", "Postcode", "Website", "VATNumber", "Notes"
    ]
    
    Finds = [ "code", "id" ]
    
    KFObject = { singular: "supplier", plural: "suppliers" }
    
    XMLKey = "SupplierID"
    
    def self.build_arguments(action, object, field, argument)
      if action == "get"
        expects argument, String
        return "<Supplier#{field}>#{argument}</Supplier#{field}>" if object == "supplier"
        return "<#{field}>#{argument}</#{field}>" if object == "customers"
      elsif action == "update"
        expects argument, KashflowApi::Supplier
        return "<sup>#{argument.to_xml}</sup>" if object == "supplier"
      elsif action == "insert"
        expects argument, KashflowApi::Supplier
        return "<supl>#{argument.to_xml}</supl>" if object == "supplier"
      end
    end
    
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