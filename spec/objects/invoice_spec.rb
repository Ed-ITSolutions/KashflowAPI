describe KashflowApi::Invoice do
  include ModelMacros
  
  it_should_be_a_soap_model(KashflowApi::Invoice)
  it_should_have_arguments(KashflowApi::Invoice, :get_invoice, "100", /<InvoiceNumber>/, :insert_invoice, /<Inv>/)
end