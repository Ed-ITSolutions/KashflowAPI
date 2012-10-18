require 'spec_helper'

describe KashflowApi do
    it "should raise an exception if username and password are not present" do
        lambda{
            KashflowApi.configure do |c|
            end
        }.should raise_error
    end
    
    it "should take a username and password" do
        KashflowApi.configure do |c|
            c.username = "Test"
            c.password = "test"
        end
    end
    
    it "should return an array of symbols for .api_methods" do
        KashflowApi.configure do |c|
            c.username = "Test"
            c.password = "test"
        end
        
        KashflowApi.api_methods.should be_a Array
        KashflowApi.api_methods.first.should be_a Symbol
    end
    
    it "should raise an exception if username and password are wrong" do
        lambda{
            KashflowApi.configure do |c|
                c.username = "Test"
                c.password = "test"
                c.loggers = false
            end
            
            KashflowApi::Customer.all
        }.should raise_error
    end
    
    it "should disable the loggers if requested" do
        KashflowApi.configure do |c|
            c.username = "Test"
            c.password = "test"
            c.loggers = false
        end
        
        KashflowApi.api_methods
    end
end