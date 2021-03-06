require 'simplecov'
SimpleCov.start

require 'yaml'
require './lib/kashflow_api'

def default_config
    KashflowApi.configure do |c|
        c.username = yaml["username"]
        c.password = yaml["password"]
        c.loggers = false
    end
end

def yaml
    @yaml ||= YAML::load(File.open('spec/test_data.yml'))
end

def test_data(field)
    @yaml[field]
end