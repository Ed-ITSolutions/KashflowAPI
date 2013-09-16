module KashflowApi
    class NominalCode < KashflowApi::SoapObject  
      Keys = [
        "Code", "Name", "Debit", "Credit", "Balance"
      ]
      
      Finds = []
      
      KFObject = { singular: "nominal_code", plural: "nominal_codes" }
      
      XMLKey = "NominalCodeID"
    end
end