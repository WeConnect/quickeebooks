require 'time'

module Quickeebooks
  module Windows
    module Model
      class InvoiceHeader < Quickeebooks::Windows::Model::IntuitType

        IS_TAXABLE = "IS_TAXABLE"

        xml_name 'Header'
        xml_accessor :doc_number, :from => 'DocNumber'
        xml_accessor :txn_date, :from => 'TxnDate', :as => Time
        xml_accessor :currency, :from => 'Currency'
        xml_accessor :msg, :from => 'Msg'
        xml_accessor :note, :from => 'Note'
        xml_accessor :status, :from => 'Status'
        xml_accessor :customer_id, :from => 'CustomerId'
        xml_accessor :customer_id_domain, :in => 'CustomerId', :from => "@idDomain"
        xml_accessor :customer_name, :from => 'CustomerName'
        xml_accessor :job_id, :from => 'JobId'
        xml_accessor :job_name, :from => 'JobName'
        xml_accessor :remit_to_id, :from => 'RemitToId'
        xml_accessor :remit_to_name, :from => 'RemitToName'
        xml_accessor :class_id, :from => 'ClassId'
        xml_accessor :class_name, :from => 'ClassName'
        xml_accessor :sales_rep_id, :from => 'SalesRepId'
        xml_accessor :sales_rep_name, :from => 'SalesRepName'
        xml_accessor :sales_tax_code_id, :from => 'SalesTaxCodeId'
        xml_accessor :sales_tax_code_name, :from => 'SalesTaxCodeName'
        xml_accessor :po_number, :from => 'PONumber'
        xml_accessor :ship_date, :from => 'ShipDate', :as => Time
        xml_accessor :sub_total_amount, :from => 'SubTotalAmt', :as => Float
        xml_accessor :tax_id, :from => 'TaxId'
        xml_accessor :tax_name, :from => 'TaxName'
        xml_accessor :tax_group_id, :from => 'TaxGroupId'
        xml_accessor :tax_group_name, :from => 'TaxGroupName'
        xml_accessor :tax_rate, :from => 'TaxRate', :as => Float
        xml_accessor :tax_amount, :from => 'TaxAmt', :as => Float
        xml_accessor :total_amount, :from => 'TotalAmt', :as => Float
        xml_accessor :to_be_printed, :from => 'ToBePrinted'
        xml_accessor :to_be_emailed, :from => 'ToBeEmailed'
        xml_accessor :custom, :from => 'Custom'
        xml_accessor :ar_account_id, :from => 'ARAccountId'
        xml_accessor :ar_account_name, :from => 'ARAccountName'
        xml_accessor :sales_term_id, :from => 'SalesTermId'
        xml_accessor :sales_term_name, :from => 'SalesTermName'
        xml_accessor :due_date, :from => 'DueDate', :as => Time
        xml_accessor :billing_address, :from => 'BillAddr', :as => Quickeebooks::Windows::Model::Address
        xml_accessor :shipping_address, :from => 'ShipAddr', :as => Quickeebooks::Windows::Model::Address
        xml_accessor :bill_email, :from => 'BillEmail'
        xml_accessor :ship_method_id, :from => 'ShipMethodId'
        xml_accessor :ship_method_name, :from => 'ShipMethodName'
        xml_accessor :balance, :from => 'Balance'
        xml_accessor :discount_amount, :from => 'DiscountAmt', :as => Float
        xml_accessor :discount_rate, :from => 'DiscountRate', :as => Float
        xml_accessor :discount_account_id, :from => 'DiscountAccountId'
        xml_accessor :discount_account_name, :from => 'DiscountAccountName'
        xml_accessor :discount_taxable, :from => 'DiscountTaxable'
        
        
        def initialize(values = {})
          self.doc_number           = values[:doc_number]
          self.msg                  = values[:msg]
          self.note                 = values[:note]
          self.status               = values[:status]
          self.ar_account_id        = values[:ar_account_id]
          self.due_date             = values[:due_date]
          self.customer_id          = values[:customer_id]
          self.customer_id_domain   = values[:customer_id_domain]
          self.total_amount         = values[:total_amount]
          self.to_be_printed        = values[:to_be_printed] ? 1 : 0
          self.to_be_emailed        = values[:to_be_emailed] ? 1 : 0
          self.custom               = values[:custom]
        end

      end
    end
  end

end