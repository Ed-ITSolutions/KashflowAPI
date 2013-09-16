describe KashflowApi::Client do
  let(:config_object) do
    config = KashflowApi::Config.new
    config.username = "foo"
    config.password = "foo"
    config
  end
  
  it "should take a config object" do
    lambda { KashflowApi::Client.new("foo") }.should raise_exception
    lambda { KashflowApi::Client.new(config_object) }.should_not raise_exception
  end
end