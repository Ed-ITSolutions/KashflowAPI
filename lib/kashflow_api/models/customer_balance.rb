module KashflowApi
    class CustomerBalance
        attr_reader :customer, :value, :balance
        
        def initialize(customer)
            result = KashflowApi.api.get_customer_balance(customer.code)
            @customer = customer
            @value = result.hash[:envelope][:body][:get_customer_balance_response][:get_customer_balance_result][:value].to_f
            @balance = result.hash[:envelope][:body][:get_customer_balance_response][:get_customer_balance_result][:balance].to_f
        end
    end
end