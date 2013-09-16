require 'spec_helper'

describe KashflowApi::ApiCall do
  let(:config) do
    KashflowApi.configure do |c|
      c.username = "Foo"
      c.password = "bar"
      c.loggers = false
    end
  end
  
  let(:example_customer) do
    hash = {}
    KashflowApi::Customer::Keys.each do |key|
      hash[[*key].first] = "foo"
    end
    KashflowApi::Customer.new(hash)
  end
  
  it "should take a method and an argument" do
    config
    
    KashflowApi::ApiCall.new("foo_bar", "bar")
  end
  
  it "should be able to work out what xml to use" do
    config
    
    KashflowApi::ApiCall.new(:get_customer, example_customer.code)
  end
end