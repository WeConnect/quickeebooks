require "quickeebooks"
require "quickeebooks/windows/model/meta_data"
require "quickeebooks/windows/model/address"
require "quickeebooks/windows/model/phone"
require "quickeebooks/windows/model/web_site"
require "quickeebooks/windows/model/email"
require "quickeebooks/windows/model/note"
require "quickeebooks/windows/model/custom_field"
require "quickeebooks/windows/model/open_balance"

module Quickeebooks
  module Windows
    module Model
      class CustomerMessage < Quickeebooks::Windows::Model::IntuitType
        include ActiveModel::Validations
        
        XML_COLLECTION_NODE = 'CustomerMsgs'
        XML_NODE = 'CustomerMsg'
        
        xml_convention :camelcase
        xml_reader   :id_domain, :in => 'Id', :from => "@idDomain"
        xml_accessor :id, :from => 'Id'
        xml_accessor :name, :from => 'Name'
        
        def to_xml_ns(options = {})
          to_xml
        end
        def self.from_xml_ns(xml, path_to_node = "//xmlns:RestResponse/xmlns:#{XML_COLLECTION_NODE}/xmlns:#{XML_NODE}")
          nodes = Nokogiri::XML(xml).xpath(path_to_node)
          
          if nodes.count > 0
            from_xml(nodes.first)
          else
            nil
          end
          
        end
        
      end
    end
  end
end
