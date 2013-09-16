describe KashflowApi::Customer do
  include ModelMacros
  
  it_should_be_a_soap_model(KashflowApi::Customer)
  
  it "should make a call for all" do
    results = KashflowApi::Customer.all
    results.first.api_call.should be_a KashflowApi::ApiCall
  end
end