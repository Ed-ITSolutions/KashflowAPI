# KashflowApi

KashflowApi provides an Active Record like interface to the Kashflow API.

# Unimplemented Methods

Some of the methods in the Kashflow API have not been implemented in this gem (yet)

# Usage

At the beginning of your program, or in an rails initializer call the configure block like so:

    KashflowApi.configure do |c|
        c.username = "Username"
		c.password = "Password"
		c.loggers = false
	end
	
I recommend settings loggers to false so that you don't get all the soap exchanges echoed out.

You can now call methods on the models e.g.

	KashflowApi::Customer.all

## Customers

* GetCustomersModifiedSince
* GetCustomerSources
* GetCustomerVATNumber
* SetCustomerVATNumber
* GetCustomerCurrency
* SetCustomerCurrency
* GetCustomerAdvancePayments

## Quotes