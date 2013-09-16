module KashflowApi
  class Customer < KashflowApi::SoapObject
    
    Keys = [
      "Code", "Name", "Contact", "Telephone", "Mobile", "Fax", "Email", "Address1", "Address2", "Address3", "Address4", "Postcode",
      "Website", "Notes", "ExtraText1", "ExtraText2", "ExtraText3", "ExtraText4", "ExtraText5", "ExtraText6", "ExtraText7", "ExtraText8",
      "ExtraText9", "ExtraText10", "ExtraText11", "ExtraText12", "ExtraText13", "ExtraText14", "ExtraText15", "ExtraText16", "ExtraText17",
      "ExtraText18", "ExtraText19", "ExtraText20", "ContactTitle", "ContactFirstName", "ContactLastName", ["CustHasDeliveryAddresss", "0"],
      "DeliveryAddress1", "DeliveryAddress2", "DeliveryAddress3", "DeliveryAddress4", "DeliveryPostcode"
    ]
        
    Finds = [ "code", "id", "email", "postcode" ]
    
    KFObject = { singular: "customer", plural: "customers" }
    
    define_methods
    
    def save
      if @hash[:customer_id] == "0"
        insert_customer
      else
        update_customer
      end 
    end
    
    def balance
      KashflowApi::CustomerBalance.new(self)
    end
    
    def to_xml
      xml = []
      id_line = ""
      @hash.keys.each do |key|
        if key == :customer_id
          id_line = "<CustomerID>#{@hash[key]}</CustomerID>" unless @hash[key] == "0"
        else
          key_name = key.to_s.split('_').map{|e| e.capitalize}.join
          xml.push("<#{key_name}>#{@hash[key]}</#{key_name}>")
        end
      end
      [id_line, xml.join].join
    end
  end
end
