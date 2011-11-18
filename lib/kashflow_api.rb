# Gems
require "savon"
# Kashflow Main Clases
require "kashflow_api/soap_object"      # Soap Object Class
# Kashflow Api Modules & Classes
require "kashflow_api/api"              # Api Class
require "kashflow_api/api_call"         # ApiCall Class
require "kashflow_api/client"           # Client Class
require "kashflow_api/config"           # Config Class
# Models
require "kashflow_api/models/customer"  # Customer Class
require "kashflow_api/models/customer_balance" # Customer Balance
# Version
require "kashflow_api/version"

module KashflowApi
    def self.configure
        @config = Config.new
        yield @config
        @api = Api.new
    end
    
    def self.config
        @config
    end
    
    def self.api
        @api
    end
    
    def self.api_methods
        @api_methods ||= Api.methods
    end
    
    def self.client
        @client ||= Client.new(@config)
    end
end
