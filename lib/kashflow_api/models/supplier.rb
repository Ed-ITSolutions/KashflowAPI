module KashflowApi
    class Supplier < KashflowApi::SoapObject
        def self.find(search)
            self.find_by_supplier_code(search)
        end
        
        def self.find_by_supplier_code(search)
            result = KashflowApi.api.get_supplier(search)
            self.build_from_soap(result.hash[:envelope][:body][:get_supplier_response][:get_supplier_result])
        end
        
        def self.find_by_supplier_id(search)
            result = KashflowApi.api.get_supplier_by_id(search)
            self.build_from_soap(result.hash[:envelope][:body][:get_supplier_by_id_response][:get_supplier_by_id_result])
        end
        
        def self.all
            result = KashflowApi.api.get_suppliers
            suppliers = []
            result.hash[:envelope][:body][:get_suppliers_response][:get_suppliers_result][:supplier].each do |supplier|
                suppliers.push self.build_from_soap supplier
            end
            suppliers.sort { |x, y| x.name <=> y.name }
        end
        
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
        
        def blank_object_hash
            {"Code" => "", "Name" => "", "Contact" => "", "Telephone" => "", "Mobile" => "", "Fax" => "", "Email" => "", "Address1" => "", "Address2" => "",
                "Address3" => "", "Address4" => "", "Postcode" => "", "Website" => "", "VATNumber" => "", "Notes" => ""}.merge(KashflowApi::Supplier.find("").hash)
        end
        
        def update_supplier
            KashflowApi.api.update_supplier(self)
        end
        
        def insert_supplier
            KashflowApi.api.insert_supplier(self)
        end
    end
end