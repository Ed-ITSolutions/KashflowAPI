module KashflowApi
    class Quote < KashflowApi::Invoice
        def self.find_by_id(search)
            result = KashflowApi.api.get_quote_by_id(search)
            self.build_from_soap(result.hash[:envelope][:body][:get_quote_by_id_response][:get_quote_by_id_result])
        end
        
        private
        
        def blank_object_hash
            {}.merge(KashflowApi::Quote.find_by_id("0").hash)
        end
    end
end