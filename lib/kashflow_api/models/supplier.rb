module KashflowApi
    class Supplier < KashflowApi::SoapObject
        def self.find(search)
            self.find_by_supplier_code(search)
        end
        
        def self.find_by_supplier_code(search)
            result = KashflowApi.api.get_supplier(search)
            self.build_from_soap(result.basic_hash["soap:Envelope"]["soap:Body"]["GetSupplierResponse"]["GetSupplierResult"])
        end
        
        def self.find_by_supplier_id(search)
            result = KashflowApi.api.get_supplier_by_id(search)
            self.build_from_soap(result.basic_hash["soap:Envelope"]["soap:Body"]["GetSupplierByIDResponse"]["GetSupplierByIDResult"])
        end
        
        def self.all
            result = KashflowApi.api.get_suppliers
            suppliers = []
            result.basic_hash["soap:Envelope"]["soap:Body"]["GetSuppliersResponse"]["GetSuppliersResult"]["Supplier"].each do |supplier|
                suppliers.push self.build_from_soap supplier
            end
            suppliers
        end
    end
end