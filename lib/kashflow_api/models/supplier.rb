module KashflowApi
  class Supplier < KashflowApi::SoapObject
    Keys = [
      "Code", "Name", "Contact", "Telephone", "Mobile", "Fax", "Email", "Address1", "Address2", "Address3", "Address4", "Postcode", "Website", "VATNumber", "Notes"
    ]
    
    Finds = [ "code", "id" ]
    
    KFObject = { singular: "supplier", plural: "suppliers" }
    
    def save
      if @hash["SupplierID"] == "0"
        insert_supplier
      else
        update_supplier
      end 
    end
      
    def to_xml
      xml = []
      id_line = ""
      @hash.keys.each do |key|
        if key == "SupplierID"
          id_line = "<#{key}>#{@hash[key]}</#{key}>" unless @hash[key] == "0"
        else
          xml.push("<#{key}>#{@hash[key]}</#{key}>")
        end
      end
      [id_line, xml.join].join
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