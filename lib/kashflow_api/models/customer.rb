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
    
    XMLKey = "CustomerID"
    
    define_methods
    
    def self.build_arguments(action, object, field, argument)
      if action == "get"
        expects argument, String
        return "<Customer#{field}>#{argument}</Customer#{field}>" if object == "customer"
        return "<#{field}>#{argument}</#{field}>" if object == "customers"
      elsif action == "update" || action == "insert"
        expects argument, KashflowApi::Customer
        return "<custr>#{argument.to_xml}</custr>" if object == "customer"
      end
    end
    
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
  end
end
