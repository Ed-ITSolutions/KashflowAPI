require 'spec/spec_helper'
# Require the gem
require 'lib/kashflow_api'

describe KashflowApi::Quote do
    before :each do
       default_config 
    end
    
    it "should create a blank quote for new" do
        quote = KashflowApi::Quote.new
        quote.should be_a KashflowApi::Quote
    end
end