module KashflowApi
    class Invoice < KashflowApi::SoapObject
      Keys = [
        "InvoiceNumber", "InvoiceDate", "DueDate", "CustomerID", "CustomerReference", ["InvoiceDBID", "0"]
      ]
        
      Finds = [ "InvoiceNumber" ]
    
      KFObject = { singular: "invoice", plural: "invoices" }
      
      XMLKey = "InvoiceDBID"
    
      define_methods
      
      def self.build_arguments(action, object, field, argument)
        if action == "get"
          expects argument, String
          return "<InvoiceNumber>#{argument}</InvoiceNumber>" if object == "invoice"
        elsif action == "update" || action == "insert"
          expects argument, KashflowApi::Invoice
          return "<InvoiceID>#{argument.invoiceid}</InvoiceID><InvLine>#{argument.to_xml}</InvLine>" if field == "Line"
          return "<InvoiceNumber>#{argument.invoicenumber}</InvoiceNumber><InvLine>#{argument.to_xml}</InvLine>" if field == "Number"
          return "<Inv>#{argument.to_xml}</Inv>" if object == "invoice"
        end
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