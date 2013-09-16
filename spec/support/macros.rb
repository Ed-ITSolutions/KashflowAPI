module ModelMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def it_should_be_a_soap_model(klass)
      it "should have the correct constants" do
        klass::Keys.should be_a Array
        klass::Finds.should be_a Array
        klass::KFObject.should be_a Hash
        klass::XMLKey.should be_a String
      end
      
      it "should have a new object hash" do
        klass.new.methods.include?(klass::Keys.first.downcase.to_sym).should be_true
      end
    end
    
    def it_should_have_arguments(klass, get_method, get_argument, get_should_find, complex_method, complex_should_find)
      it "should have the build_arguments method" do
        klass.methods.include?(:build_arguments).should be_true
      end
      
      it "should have 2 branches to build_arguments" do
        klass.build_arguments(:foo, :bar, :widget, "string")
        klass.build_arguments(:foo, :bar, :widget, klass.new)
      end
      
      it "should be called by ApiCall" do
        KashflowApi.configure do |c|
          c.username = "foo"
          c.password = "bar"
          c.loggers = false
        end
    
        call = KashflowApi::ApiCall.new(get_method, get_argument)
        call.xml.should =~ get_should_find
      end
      
      it "should be called by ApiCall" do
        KashflowApi.configure do |c|
          c.username = "foo"
          c.password = "bar"
          c.loggers = false
        end
    
        call = KashflowApi::ApiCall.new(complex_method, klass.new)
        call.xml.should =~ complex_should_find
      end
    end
  end
end