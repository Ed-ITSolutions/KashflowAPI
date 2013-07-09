module KashflowApi
    class NominalCode < KashflowApi::SoapObject  
        def self.all
            result = KashflowApi.api.get_nominal_codes
            codes = []
            result.hash[:envelope][:body][:get_nominal_codes_response][:get_nominal_codes_result][:nominal_code].each do |code|
                codes.push(self.build_from_soap(code))
            end
            codes
        end
    end
end