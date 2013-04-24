require 'quickeebooks/windows/service/service_base'
require 'nokogiri'

module Quickeebooks
  module Windows
    module Service
      class Customer < Quickeebooks::Windows::Service::ServiceBase

        def list(filters = [], page = 1, per_page = 20, sort = nil, options = {}, custom_field_query = nil)
          fetch_collection("customer", "Customer", Quickeebooks::Windows::Model::Customer, custom_field_query, filters, page, per_page, sort, options)
        end
        
        def fetch_by_id(id, params = {:idDomain => 'QB'})
          url = "#{url_for_resource("customer")}/#{id}"
          response = do_http_get(url, params)
          if response && response.code.to_i == 200
            Quickeebooks::Windows::Model::Customer.from_xml_ns(response.body)
          else
            nil
          end
        end   
        
        def update(customer)
          raise InvalidModelException.new("Missing required parameters for update") unless customer.valid_for_update?
          url = "#{url_for_resource("customer")}"
          xml = customer.to_update_xml(@realm_id)
          response = do_http_post(url, xml)
          if response.code.to_i == 200
            path_to_node = "//xmlns:RestResponse/xmlns:Success/xmlns:#{Quickeebooks::Windows::Model::Customer::XML_NODE}"
            Quickeebooks::Windows::Model::Customer.from_xml_ns(response.body, path_to_node)
          else
            nil
          end
        end        

        def create(customer)
          url = "#{url_for_resource("customer")}"
#          xml = customer.to_xml_ns
          xml = customer.to_create_xml(@realm_id)
          response = do_http_post(url, xml)
          if response.code.to_i == 200
            path_to_node = "//xmlns:RestResponse/xmlns:Success/xmlns:#{Quickeebooks::Windows::Model::Customer::XML_NODE}"
            Quickeebooks::Windows::Model::Customer.from_xml_ns(response.body, path_to_node)
          else
            nil
          end
        end
        
        def revert(customer)
          xml = customer.to_revert_xml
          response = do_http_post(url_for_resource("customer"), xml)
          if response.code.to_i == 200
            path_to_node = "//xmlns:RestResponse/xmlns:Success"
            Quickeebooks::Windows::Model::Customer.from_xml_ns(response.body, path_to_node)
          else
            nil
          end        
        end

        def delete(customer)
          xml = customer.to_delete_xml
          response = do_http_post(url_for_resource("customer"), xml)
          if response.code.to_i == 200
            path_to_node = "//xmlns:RestResponse/xmlns:Success"
            Quickeebooks::Windows::Model::Customer.from_xml_ns(response.body, path_to_node)
          else
            nil
          end        
        end        
      end
    end
  end
end