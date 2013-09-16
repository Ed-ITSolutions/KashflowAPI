module KashflowApi
  class Quote < KashflowApi::Invoice
    KFObject = {singular: "quote", plural: "quotes"}
  end
end