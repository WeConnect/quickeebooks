require "quickeebooks"
require "quickeebooks/online/model/meta_data"
require "quickeebooks/online/model/address"
require "quickeebooks/online/model/phone"
require "quickeebooks/online/model/web_site"
require "quickeebooks/online/model/email"
require "quickeebooks/online/model/note"
require "quickeebooks/online/model/customer_custom_field"
require "quickeebooks/online/model/open_balance"

module Quickeebooks
  module Online
    module Model
      class Customer < Quickeebooks::Online::Model::IntuitType
        include ActiveModel::Validations

        xml_convention :camelcase
        xml_accessor :id, :from => 'Id'
        xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
        xml_accessor :name, :from => 'Name'
        xml_accessor :meta_data, :from => 'MetaData', :as => Quickeebooks::Online::Model::MetaData
        xml_accessor :addresses, :from => 'Address', :as => [Quickeebooks::Online::Model::Address]
        xml_accessor :email, :from => 'Email', :as => Quickeebooks::Online::Model::Email
        xml_accessor :phones, :from => 'Phone', :as => [Quickeebooks::Online::Model::Phone]
        xml_accessor :web_site, :from => 'WebSite', :as => Quickeebooks::Online::Model::WebSite
        xml_accessor :given_name, :from => 'GivenName'
        xml_accessor :middle_name, :from => 'MiddleName'
        xml_accessor :family_name, :from => 'FamilyName'
        xml_accessor :suffix, :from => 'Suffix'
        xml_accessor :gender, :from => 'Gender'
        xml_accessor :dba_name, :from => 'DBAName'
        xml_accessor :notes, :from => 'Notes', :as => [Quickeebooks::Online::Model::Note]
        xml_accessor :custom_fields, :from => 'CustomField', :as => [Quickeebooks::Online::Model::CustomerCustomField]
        xml_accessor :sales_term_id, :from => 'SalesTermId'
        xml_accessor :paymethod_method_id, :from => 'PaymentMethodId'
        xml_accessor :open_balance, :from => 'OpenBalance', :as => Quickeebooks::Online::Model::OpenBalance

        validates_length_of :name, :minimum => 1

        def valid_for_update?
          if sync_token.nil?
            errors.add(:sync_token, "Missing required attribute SyncToken for update")
          end
          errors.empty?
        end

        def to_xml_ns(options = {})
          to_xml_inject_ns('Customer', options)
        end

        def email_address=(email_address)
          self.email = Quickeebooks::Online::Model::Email.new(email_address)
        end

        # To delete an account Intuit requires we provide Id and SyncToken fields
        def valid_for_deletion?
          return false if(id.nil? || sync_token.nil?)
          id.to_i > 0 && !sync_token.to_s.empty? && sync_token.to_i >= 0
        end

      end
    end
  end

end
