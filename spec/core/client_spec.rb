describe KashflowApi::Client do
  let(:config_object) do
    config = KashflowApi::Config.new
    config.username = "foo"
    config.password = "foo"
    config
  end
  
  let(:instance) do
    KashflowApi::Client.new(config_object)
  end
  
  it "should take a config object" do
    lambda { KashflowApi::Client.new("foo") }.should raise_exception
    lambda { KashflowApi::Client.new(config_object) }.should_not raise_exception
  end
  
  it "should raise errors" do
    lambda { instance.handle_errors([{stauts_detail: "Incorrect username or password"}]) }.should raise_exception
    lambda { instance.handle_errors([{stauts_detail: "The IP address of 127.0.0.1 is not in the access list"}]) }.should raise_exception
    lambda { instance.handle_errors([{status: "NO", stauts_detail: "There was a problem"}]) }.should raise_exception
  end
end