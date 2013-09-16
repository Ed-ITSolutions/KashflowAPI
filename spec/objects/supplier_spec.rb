describe KashflowApi::Supplier do
  include ModelMacros
  
  it_should_be_a_soap_model(KashflowApi::Supplier)
  it_should_have_arguments(KashflowApi::Supplier, :get_supplier, "100", /<SupplierCode>/, :insert_supplier, /<supl>/)
end