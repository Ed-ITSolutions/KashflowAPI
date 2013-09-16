#require 'spec_helper'

describe KashflowApi do
  it "should accept a config block" do
    KashflowApi.configure do |c|
      c.username = "foo"
      c.password = "bar"
    end
  end
  
  it "should raise an exception if you don't provide a username and password" do
    lambda { KashflowApi.configure do |c| end }.should raise_exception
  end
end