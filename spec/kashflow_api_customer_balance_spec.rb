require 'spec_helper'

describe KashflowApi::CustomerBalance do
    before :each do
        default_config
    end
    
    it "should create a new balance object" do
       customer = KashflowApi::Customer.find(test_data("customer_code"))
       customer.balance.should be_a KashflowApi::CustomerBalance 
    end
    
    it "should have a balance and a value" do
        customer = KashflowApi::Customer.find(test_data("customer_code"))
        customer.balance.value.should be_a Float
        customer.balance.balance.should be_a Float
    end
end