require 'quickeebooks/windows/model/ng_id_set'
require 'quickeebooks/windows/model/sync_status_param'

module Quickeebooks
  module Windows
    module Model
      class Status < Quickeebooks::Windows::Model::IntuitType

        XML_COLLECTION_NODE = 'SyncStatusResponses'
        XML_NODE = 'SyncStatusResponse'

        xml_convention :camelcase
        xml_accessor :offering_id, :from => 'OfferingId'
        xml_accessor :ng_id_set, :from => 'NgIdSet', :as => Quickeebooks::Windows::Model::NgIdSet
        xml_accessor :sync_status_param, :from => 'SyncStatusParam', :as => Quickeebooks::Windows::Model::SyncStatusParam
        xml_accessor :request_id, :from => 'RequestId'
        xml_accessor :batch_id, :from => 'BatchId'
        xml_accessor :start_created_tms, :from => 'StartCreatedTMS', :as => Time
        xml_accessor :end_created_tms, :from => 'EndCreatedTMS', :as => Time

        def to_xml_ns(options = {})
          to_xml(options)
          builder = Nokogiri::XML::Builder.new do |xml|
            xml.SyncStatusRequest('xmlns' => "http://www.intuit.com/sb/cdm/v2", 'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'xsi:schemaLocation' => "http://www.intuit.com/sb/cdm/xmlrequest RestDataFilter.xsd") do
              xml.OfferingId 'ipp'
              if ng_id_set
                xml.NgIdSet do
                  xml.NgId ng_id_set.ng_id
                  xml.NgObjectType ng_id_set.ng_object_type
                end
              end

              if sync_status_param
                xml.SyncStatusRequest do
                  xml.IdSet do
                    xml.Id sync_status_param.id_set.id
                  end
                  xml.ObjectType sync_status_param.object_type
                end
              end

              xml.RequestId request_id if request_id
              xml.BatchId batch_id if batch_id
              xml.StartCreatedTMS start_created_tms.iso8601 if start_created_tms
              xml.EndCreatedTMS end_created_tms.iso8601 if end_created_tms
            end
          end
          builder.doc.children[0]['ErroredObjectsOnly']="true" if options[:errored_objects_only]
          builder.to_xml          
        end

        def self.from_xml_ns(xml, path_to_node = "//xmlns:RestResponse/xmlns:#{XML_COLLECTION_NODE}/xmlns:#{XML_NODE}")
          nodes = Nokogiri::XML(xml).xpath(path_to_node)
          if nodes.count > 0
            # from_xml(nodes.first)
            node = nodes.first
            {:state_code => node.at('StateCode').text, :state_desc => node.at('StateDesc').text, :message_code => node.at('MessageCode').text, :message_desc => node.at('MessageDesc').text}
          else
            nil
          end

        end

      end
    end
  end

end