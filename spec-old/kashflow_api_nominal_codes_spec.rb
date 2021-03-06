require 'spec_helper'

describe KashflowApi::CustomerBalance do
    before :each do
        default_config
    end
    
    it "should find all nominal codes" do
        all = KashflowApi::NominalCode.all
        all.should be_a Array
        all.first.should be_a KashflowApi::NominalCode
    end
end