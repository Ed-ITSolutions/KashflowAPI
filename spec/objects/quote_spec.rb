describe KashflowApi::Quote do
  include ModelMacros
  
  it_should_be_a_soap_model(KashflowApi::Quote)
  
  it "should have overriden kfobjects from invoice" do
    KashflowApi::Quote::KFObject[:singular].should eq "quote"
  end
end