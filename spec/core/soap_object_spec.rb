describe KashflowApi::SoapObject do

  let(:test_hash) do
    { "CustomerID" => 1234, "Code" => "CUST01" }
  end
  
  let(:instance) do
    KashflowApi::SoapObject.new(test_hash)
  end
  
  it "should take a hash" do
    lambda { instance }.should_not raise_exception
    lambda { KashflowApi::SoapObject.new("foo") }.should raise_exception
  end
  
  it "should create additional methods" do
    instance.customerid = 12345
    instance.customerid.should eq 12345
  end
  
  it "should have placed some classes into the soap_objects array" do
    KashflowApi.soap_objects.should be_a Array
    KashflowApi.soap_objects.first.should be_a Class
  end
end