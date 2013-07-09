require 'spec_helper'

describe KashflowApi::Supplier do
    before :each do
        default_config
    end
    
    it "should find a supplier" do
        KashflowApi::Supplier.find(test_data("supplier_code")).should be_a KashflowApi::Supplier
        KashflowApi::Supplier.find_by_supplier_code(test_data("supplier_code")).should be_a KashflowApi::Supplier
    end
    
    it "should return an array for .all" do
        all = KashflowApi::Supplier.all
        all.should be_a Array
        all.first.should be_a KashflowApi::Supplier
    end
    
    it "should find a supplier by kashflowid" do
        id = KashflowApi::Supplier.find(test_data("supplier_code")).supplier_id
        KashflowApi::Supplier.find_by_supplier_id(id).should be_a KashflowApi::Supplier
    end
end
