module KashflowApi
    class Invoice < KashflowApi::SoapObject
      Keys = [
        "InvoiceNumber", "InvoiceDate", "DueDate", "CustomerID", "CustomerReference", ["InvoiceDBID", "0"]
      ]
        
      Finds = [ "InvoiceNumber" ]
    
      KFObject = { singular: "invoice", plural: "invoices" }
      
      XMLKey = "InvoiceDBID"
    
      define_methods
      
      def customer=(cust)
        
      end
        
        def customer
            KashflowApi::Customer.find_by_customer_id(self.customerid)
        end
        
        def save
            if @hash["InvoiceDBID"] == "0"
                insert_invoice
            else
                update_invoice
            end
        end
        
        private
        
        def update_invoice
            KashflowApi.api.update_invoice(self)
        end

        def insert_invoice
            KashflowApi.api.insert_invoice(self)
        end
    end
end