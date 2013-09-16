require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'kashflow_api'

require 'support/macros'

module KashflowApi
  def self.blank
    @api = nil
    @client = nil
    @config = nil
  end
  
  class Client
    def call(api_call)
      klass = Class.new do
        def initialize(call)
          @call = call
        end
        
        def hash
          { envelope: { body: { get_customers_response: { get_customers_result: { customer: [ { api_call: @call } ] } } } } }
        end
      end
      return klass.new(api_call)
    end
  end
  
  class Api
    def get_foos
      klass = Class.new do
        def hash
          { envelope: { body: { get_foos_response: { get_foos_result: { foo: [] } } } } }
        end
      end
      
      return klass.new
    end
    
    def get_foo(search)
      klass = Class.new do
        def hash
          { envelope: { body: { get_foo_response: { get_foo_result: { foo: [] } } } } }
        end
      end
      
      return klass.new
    end
    
    def get_foo_by_bar(search)
      klass = Class.new do
        def hash
          { envelope: { body: { get_foo_by_bar_response: { get_foo_by_bar_result: { foo: [] } } } } }
        end
      end
      
      return klass.new
    end
  end
end