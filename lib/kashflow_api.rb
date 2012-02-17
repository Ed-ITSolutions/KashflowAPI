# Gems
require "savon"
# Kashflow Main Clases
require "kashflow_api/soap_object"      # Soap Object Class
require "kashflow_api/config"           # Config Class
# Kashflow Api Modules & Classes
require "kashflow_api/api"              # Api Class
require "kashflow_api/api_call"         # ApiCall Class
require "kashflow_api/client"           # Client Class
# Models
require "kashflow_api/models/customer"  # Customer Class
require "kashflow_api/models/customer_balance" # Customer Balance
require "kashflow_api/models/invoice"   # Invoice Class
require "kashflow_api/models/line"      # Invoice Line 
require "kashflow_api/models/nominal_code" # Nominal Code
require "kashflow_api/models/quote"     # Quote Class
require "kashflow_api/models/receipt"   # Receipt Class
require "kashflow_api/models/supplier"  # Supplier
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
