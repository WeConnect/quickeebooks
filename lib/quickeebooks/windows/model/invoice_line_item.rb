module Quickeebooks
  module Windows
    module Model
      class InvoiceLineItem < Quickeebooks::Windows::Model::IntuitType
        xml_name 'Line'
        xml_reader   :id_domain, :in => 'Id', :from => "@idDomain"
        xml_accessor :id, :from => 'Id'
        xml_accessor :desc, :from => 'Desc'
        xml_accessor :group_member, :from => 'GroupMember'
        xml_accessor :custom_fields, :from => 'CustomField', :as => [Quickeebooks::Windows::Model::CustomField]
        xml_accessor :amount, :from => 'Amount', :as => Float
        xml_accessor :class_id, :from => 'ClassId'
        xml_accessor :class_name, :from => 'ClassName'
        xml_accessor :taxable, :from => 'Taxable'
        xml_accessor :item_id, :from => 'ItemId'
        xml_accessor :item_name, :from => 'ItemName'
        xml_accessor :item_type, :from => 'ItemType'        
        xml_accessor :unit_price, :from => 'UnitPrice', :as => Float
        xml_accessor :rate_percent, :from => 'RatePercent', :as => Float
        xml_accessor :price_level_id, :from => 'PriceLevelId'
        xml_accessor :price_level_name, :from => 'PriceLevelName'
        xml_accessor :uom_id, :from => 'UOMId'
        xml_accessor :uom_abbrev, :from => 'UOMAbbrv'
        xml_accessor :override_item_account_id, :from => 'OverrideItemAccountId'
        xml_accessor :override_item_account_name, :from => 'OverrideItemAccountName'
        xml_accessor :discount_id, :from => 'DiscountId'
        xml_accessor :discount_name, :from => 'DiscountName'
        xml_accessor :quantity, :from => 'Qty', :as => Float
        xml_accessor :sales_tax_code_id, :from => 'SalesTaxCodeId'
        xml_accessor :sales_tax_code_name, :from => 'SalesTaxCodeName'
        xml_accessor :service_date, :from => 'ServiceDate', :as => Time
        xml_accessor :custom1, :from => 'Custom1'
        xml_accessor :custom2, :from => 'Custom2'
        xml_accessor :txn_id, :from => 'TxnId'
        xml_accessor :txn_line_id, :from => 'TxnLineId'
        
        def initialize(values = {})
          self.item_id    = values[:item_id]
          self.desc       = values[:desc]
          self.amount     = values[:amount]
          self.sales_tax_code_id = values[:sales_tax_code_id]
          self.quantity   = values[:quantity]
          self.unit_price = values[:unit_price]
        end
      end
    end
  end
end