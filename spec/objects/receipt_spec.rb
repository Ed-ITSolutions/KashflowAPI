describe KashflowApi::Receipt do
  include ModelMacros
  
  it_should_be_a_soap_model(KashflowApi::Receipt)
  it_should_have_arguments(KashflowApi::Receipt, :get_receipt, "100", /<ReceiptNumber>/, :insert_receipt, /<Inv>/)
end