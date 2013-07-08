require 'rubygems'
require "bundler/gem_tasks"
require 'savon'

desc "List API Operations"
task :list_api_operations do
  client = Savon.client(wsdl: "https://securedwebapp.com/api/service.asmx?WSDL")
  puts client.operations
end