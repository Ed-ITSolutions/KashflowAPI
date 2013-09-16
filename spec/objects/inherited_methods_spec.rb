describe "Inherited Methods" do
  class SampleClass < KashflowApi::SoapObject
    Key = [ "Foo", "Bar" ]

    Finds = [ "foo", "bar" ]
      
    KFObject = { singular: "foo", plural: "foos" }
    
    define_methods
  end
  
  it "should define find_* methods" do
    SampleClass.methods.include?(:find_by_bar).should be_true
  end
  
  it "should define find" do
    SampleClass.methods.include?(:find).should be_true
    SampleClass.methods.include?(:find_by_foo).should be_false
  end
  
  it "should find all" do
    SampleClass.all.should be_a Array
  end
  
  it "should find by bar" do
    SampleClass.find_by_bar("search")
  end
end