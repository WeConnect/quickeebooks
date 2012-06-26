require 'quickeebooks/windows/model/invoice_header'
require 'quickeebooks/windows/model/invoice_line_item'
require 'quickeebooks/windows/model/address'
require 'quickeebooks/windows/model/meta_data'
require 'quickeebooks/windows/model/tax_line'

module Quickeebooks
  module Windows
    module Model
      class Invoice < Quickeebooks::Windows::Model::IntuitType
        include ActiveModel::Validations
        
        XML_COLLECTION_NODE = 'Invoices'
        XML_NODE = 'Invoice'
        
        xml_convention :camelcase
        xml_accessor :id_domain, :in => 'Id', :from => "@idDomain"
        xml_accessor :id, :from => 'Id', :as => Integer
        xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
        xml_accessor :meta_data, :from => 'MetaData', :as => Quickeebooks::Windows::Model::MetaData
        xml_accessor :external_key, :from => 'ExternalKey'
        xml_accessor :synchronized, :from => 'Synchronized'
        xml_accessor :custom_fields, :from => 'CustomField', :as => [Quickeebooks::Windows::Model::CustomField]
        xml_accessor :draft
        xml_accessor :object_state, :from => 'ObjectState'
        xml_accessor :header, :from => 'Header', :as => Quickeebooks::Windows::Model::InvoiceHeader
        xml_accessor :line_items, :from => 'Line', :as => [Quickeebooks::Windows::Model::InvoiceLineItem]
        xml_accessor :tax_line, :from => 'TaxLine', :as => Quickeebooks::Windows::Model::TaxLine
        
        validates_length_of :line_items, :minimum => 1
        
        def initialize
          ensure_line_items_initialization
        end
        
        def to_create_xml(realm_id)
          builder = Nokogiri::XML::Builder.new do |xml|
            xml.Add('FullResponse' => "true",  'xmlns' => "http://www.intuit.com/sb/cdm/v2",  'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'RequestId' => "#{ SecureRandom.hex}",  'xsi:schemaLocation' => "http://www.intuit.com/sb/cdm/V2./RestDataFilter.xsd") do
              xml.OfferingId 'ipp'
              xml.ExternalRealmId realm_id
              xml.Invoice do
                xml.Header do
                  xml.DocNumber header.doc_number
                  xml.Msg header.msg
                  xml.Note header.note
                  xml.Status header.status
                  xml.CustomerId header.customer_id, :idDomain => header.customer_id_domain
                  xml.TotalAmt header.total_amount if header.total_amount
                  #                  xml.ARAccountID header.ar_account_id, :idDomain => "QB"
                  xml.ToBePrinted header.to_be_printed
                  xml.ToBeEmailed header.to_be_emailed
                  xml.Custom header.custom
                  xml.DueDate header.due_date.iso8601
                  if header.billing_address
                    xml.BillAddr do
                      xml.Line1  header.billing_address.line1
                      xml.Line2  header.billing_address.line2
                      xml.Line3  header.billing_address.line3
                      xml.Line4  header.billing_address.line4
                      xml.Line5  header.billing_address.line5
                      xml.City   header.billing_address.city
                      xml.Country header.billing_address.country
                      xml.PostalCode header.billing_address.postal_code
                      xml.Default header.billing_address.default
                      xml.Tag header.billing_address.tag
                    end
                  end
                end
                if line_items.present?
                  line_items.each do |li|
                    xml.Line do 
                      xml.Desc li.desc 
                      xml.Amount li.amount
                      xml.Taxable 0
                      xml.ItemId li.item_id, :idDomain => 'QB'
                      xml.UnitPrice li.unit_price
                      xml.Qty li.quantity
                      xml.SalesTaxCodeId li.sales_tax_code_id, :idDomain => 'QB'
                    end
                  end
                end
              end
            end
          end
          builder.to_xml    
          
        end
        
        def to_update_xml(realm_id)
          builder = Nokogiri::XML::Builder.new do |xml|
            xml.Mod('FullResponse' => "true",  'xmlns' => "http://www.intuit.com/sb/cdm/v2",  'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'RequestId' => "#{ SecureRandom.hex}",  'xsi:schemaLocation' => "http://www.intuit.com/sb/cdm/V2./RestDataFilter.xsd") do
              xml.OfferingId 'ipp'
              xml.ExternalRealmId realm_id
              xml.Invoice do
                xml.Id id, :idDomain => id_domain
                xml.SyncToken sync_token  
                xml.Header do
                  xml.DocNumber header.doc_number
                  xml.Msg header.msg
                  xml.Note header.note
                  xml.Status header.status
                  xml.CustomerId header.customer_id, :idDomain => header.customer_id_domain
                  xml.TotalAmt header.total_amount if header.total_amount
                  #                  xml.ARAccountID header.ar_account_id, :idDomain => "QB"
                  xml.ToBePrinted header.to_be_printed
                  xml.ToBeEmailed header.to_be_emailed
                  xml.Custom header.custom
                  xml.DueDate header.due_date.iso8601
                  if header.billing_address
                    xml.BillAddr do
                      xml.Line1  header.billing_address.line1
                      xml.Line2  header.billing_address.line2
                      xml.Line3  header.billing_address.line3
                      xml.Line4  header.billing_address.line4
                      xml.Line5  header.billing_address.line5
                      xml.City   header.billing_address.city
                      xml.Country header.billing_address.country
                      xml.PostalCode header.billing_address.postal_code
                      xml.Default header.billing_address.default
                      xml.Tag header.billing_address.tag
                    end
                  end
                end
                if line_items.present?
                  line_items.each do |li|
                    xml.Line do 
                      xml.Id li.id, :idDomain => li.id_domain if li.id
                      xml.Desc li.desc
                      xml.Amount li.amount if li.amount
                      xml.Taxable 0
                      xml.ItemId li.item_id, :idDomain => 'QB'
                      xml.UnitPrice li.unit_price
                      xml.Qty li.quantity
                      xml.SalesTaxCodeId li.sales_tax_code_id, :idDomain => 'QB'
                    end
                  end
                end
              end
            end
          end
          builder.to_xml    
          
        end
        
        def self.from_xml_ns(xml, path_to_node = "//xmlns:RestResponse/xmlns:#{XML_COLLECTION_NODE}/xmlns:#{XML_NODE}")
          nodes = Nokogiri::XML(xml).xpath(path_to_node)
          
          if nodes.count > 0
            from_xml(nodes.first)
          else
            nil
          end
          
        end
        
        
        private
        
        def after_parse
        end
        
        def ensure_line_items_initialization
          self.line_items ||= []
        end
        
      end
    end
  end
  
end