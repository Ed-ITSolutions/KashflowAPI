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
  end
end