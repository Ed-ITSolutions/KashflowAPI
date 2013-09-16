describe KashflowApi::Quote do
  include ModelMacros
  
  it_should_be_a_soap_model(KashflowApi::Quote)
  it_should_have_arguments(KashflowApi::Quote, :get_quote_by_number, "100", /<QuoteNumber>/, :insert_quote, /<Inv>/)
  
  it "should have overriden kfobjects from invoice" do
    KashflowApi::Quote::KFObject[:singular].should eq "quote"
  end
end