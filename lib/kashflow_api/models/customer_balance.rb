module KashflowApi
    class CustomerBalance
        attr_reader :customer, :value, :balance
        
        def initialize(customer)
            result = KashflowApi.api.get_customer_balance(customer.code)
            @customer = customer
            @value = result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomerBalanceResponse"]["GetCustomerBalanceResult"]["Value"].to_f
            @balance = result.basic_hash["soap:Envelope"]["soap:Body"]["GetCustomerBalanceResponse"]["GetCustomerBalanceResult"]["Balance"].to_f
        end
    end
end