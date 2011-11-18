module KashflowApi
    class Customer < KashflowApi::SoapObject    
        def self.find(search)
            self.find_by_customer_code(search)
        end
        
        def self.find_by_customer_code(search)
            result = KashflowApi.api.get_customer(search)
            self.build_from_soap(result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomerResponse"]["GetCustomerResult"])
        end
        
        def self.find_by_customer_id(search)
            result = KashflowApi.api.get_customer_by_id(search)
            self.build_from_soap(result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomerByIDResponse"]["GetCustomerByIDResult"])
        end
        
        def self.find_by_customer_email(search)
            result = KashflowApi.api.get_customer_by_email(search)
            self.build_from_soap(result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomerByEmailResponse"]["GetCustomerByEmailResult"])
        end
        
        def self.find_by_postcode(search)
            result = KashflowApi.api.get_customers_by_postcode(search)
            self.build_from_soap(result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomersByPostcodeResponse"]["GetCustomersByPostcode"])
        end
        
        def self.all
            result = KashflowApi.api.get_customers
            customers = []
            result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomersResponse"]["GetCustomersResult"]["Customer"].each do |customer|
                customers.push self.build_from_soap customer
            end
            customers
        end
        
        def save
           if @hash["CustomerID"] == "0"
               insert_customer
           else
               update_customer
           end 
        end
        
        def destroy
            KashflowApi.api.delete_customer(self.customerid)
        end
        
        def balance
            KashflowApi::CustomerBalance.new(self)
        end
        
        def to_xml
            xml = []
            id_line = ""
            @hash.keys.each do |key|
                if key == "CustomerID"
                    id_line = "<#{key}>#{@hash[key]}</#{key}>" unless @hash[key] == "0"
                else
                    xml.push("<#{key}>#{@hash[key]}</#{key}>")
                end
            end
            [id_line, xml.join].join
        end
        
        private
        
        def blank_object_hash
            {"Code" => "", "Name" => "", "Contact" => "", "Telephone" => "", "Mobile" => "", "Fax" => "", "Email" => "", "Address1" => "", "Address2" => "",
                "Address3" => "", "Address4" => "", "Postcode" => "", "Website" => "", "Notes" => "", "ExtraText1" => "", "ExtraText2" => "",
                "ExtraText3"  => "", "ExtraText4" => "", "ExtraText5" => "", "ExtraText6" => "", "ExtraText7" => "", "ExtraText8" => "", "ExtraText9"  => "",
                "ExtraText10" => "", "ExtraText11" => "", "ExtraText12" => "", "ExtraText13" => "", "ExtraText14" => "", "ExtraText15" => "",
                "ExtraText16" => "", "ExtraText17" => "", "ExtraText18" => "", "ExtraText19" => "", "ExtraText20" => "", "ContactTitle" => "",
                "ContactFirstName" => "", "ContactLastName" => "", "CustHasDeliveryAddress" => "0", "DeliveryAddress1" => "",
                "DeliveryAddress2" => "", "DeliveryAddress3" => "", "DeliveryAddress4" => "", "DeliveryPostcode"  => ""}.merge(KashflowApi::Customer.find("").hash)
        end
        
        def update_customer
            KashflowApi.api.update_customer(self)
        end
        
        def insert_customer
            KashflowApi.api.insert_customer(self)
        end
    end
end