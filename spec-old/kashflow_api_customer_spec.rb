require 'spec_helper'

describe KashflowApi::Customer do
    before :each do
        default_config
    end
    
    it "should find a customer" do
        KashflowApi::Customer.find_by_customer_code(test_data("customer_code")).should be_a KashflowApi::Customer
        KashflowApi::Customer.find(test_data("customer_code")).should be_a KashflowApi::Customer
    end
    
    it "a found customer should have a name" do
        KashflowApi::Customer.find_by_customer_code(test_data("customer_code")).name.should eq(test_data("customer_name"))
    end
    
    it "should return an array for .all" do
        all = KashflowApi::Customer.all
        all.should be_a Array
        all.first.should be_a KashflowApi::Customer
    end
    
    it "should find a customer by kashflowid" do
        id = KashflowApi::Customer.find(test_data("customer_code")).customer_id
        KashflowApi::Customer.find_by_customer_id(id).should be_a KashflowApi::Customer 
    end
    
    it "should find a customer by email" do
        KashflowApi::Customer.find_by_customer_email(test_data("customer_email")).should be_a KashflowApi::Customer
    end
    
    it "should find a customer by postcode" do
        KashflowApi::Customer.find_by_postcode(test_data("customer_postcode")).should be_a KashflowApi::Customer
    end
    
    it "should create a blank customer for a new" do
        customer = KashflowApi::Customer.new
        customer.should be_a KashflowApi::Customer
        customer.name.should eq("")
    end
    
    it "should set values" do
        customer = KashflowApi::Customer.find(test_data("customer_code"))
        check = customer.name
        customer.name = "testing"
        customer.name.should_not eq check
    end
    
    it "should update a customer" do
      customer = KashflowApi::Customer.new
      customer.code = "RSPEC"
      customer.name = "Rspec Test School"
      customer.save
      search = KashflowApi::Customer.find("RSPEC")
      search.name.should eq "Rspec Test School"
      search.address1.should be_nil
      search.address1 = "rspec"
      search.save
      search = KashflowApi::Customer.find("RSPEC")
      search.name.should eq "Rspec Test School"
      search.address1.should eq "rspec"
      search = KashflowApi::Customer.find("RSPEC")
      search.name.should eq "Rspec Test School"
      search.destroy
    end
    
    it "should create a new customer and then destroy it" do
        customer = KashflowApi::Customer.new
        customer.name = "Rspec Test School"
        customer.code = "RSPEC"
        customer.save
        search = KashflowApi::Customer.find("RSPEC")
        search.name.should eq "Rspec Test School"
        search.destroy
    end
end