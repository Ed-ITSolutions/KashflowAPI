module KashflowApi
  class Quote < KashflowApi::Invoice
    
    KFObject = {singular: "quote", plural: "quotes"}
    
    def self.build_arguments(action, object, field, argument)
      if action == "get"
        expects argument, String
        return "<Quote#{field}>#{argument}</Quote#{field}>" if object == "quote"
      elsif action == "update" || action == "insert"
        expects argument, KashflowApi::Quote
        return "<InvoiceID>#{argument.invoiceid}</InvoiceID><InvLine>#{argument.to_xml}</InvLine>" if field == "Line"
        return "<InvoiceNumber>#{argument.invoicenumber}</InvoiceNumber><InvLine>#{argument.to_xml}</InvLine>" if field == "Number"
        return "<Inv>#{argument.to_xml}</Inv>" if object == "quote"
      end
    end
  end
end