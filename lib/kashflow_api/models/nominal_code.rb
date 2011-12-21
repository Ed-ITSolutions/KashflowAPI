module KashflowApi
    class NominalCode < KashflowApi::SoapObject  
        def self.all
            result = KashflowApi.api.get_nominal_codes
            codes = []
            result.basic_hash["soap:Envelope"]["soap:Body"]["GetNominalCodesResponse"]["GetNominalCodesResult"]["NominalCode"].each do |code|
                codes.push(self.build_from_soap(code))
            end
            codes
        end
    end
end