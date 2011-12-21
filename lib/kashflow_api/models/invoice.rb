module KashflowApi
    class Invoice < KashflowApi::SoapObject
        def customer
            KashflowApi::Customer.find_by_customer_id(self.customerid)
        end
    end
end