require 'quickeebooks/windows/service/service_base'
require 'quickeebooks/windows/model/invoice'
require 'quickeebooks/windows/model/invoice_header'
require 'quickeebooks/windows/model/invoice_line_item'
require 'tempfile'

module Quickeebooks
  module Windows
    module Service
      class Invoice < Quickeebooks::Windows::Service::ServiceBase


        # Fetch a +Collection+ of +Invoice+ objects
        # Arguments:
        # filters: Array of +Filter+ objects to apply
        # page: +Fixnum+ Starting page
        # per_page: +Fixnum+ How many results to fetch per page
        # sort: +Sort+ object
        # options: +Hash+ extra arguments
        def list(filters = [], page = 1, per_page = 20, sort = nil, options = {})
          fetch_collection("invoice", "Invoice", Quickeebooks::Windows::Model::Invoice, nil, filters, page, per_page, sort, options)
        end
        
        def create(invoice)
          raise InvalidModelException unless invoice.valid?
          xml = invoice.to_create_xml(@realm_id)
          response = do_http_post(url_for_resource("invoice"), xml)
          if response.code.to_i == 200
            path_to_node = "//xmlns:RestResponse/xmlns:Success/xmlns:#{Quickeebooks::Windows::Model::Invoice::XML_NODE}"
            Quickeebooks::Windows::Model::Invoice.from_xml_ns(response.body, path_to_node)
          else
            nil
          end
        end 
        
        def update(invoice)
#          raise InvalidModelException.new("Missing required parameters for update") unless invoice.valid_for_update?
          xml = invoice.to_update_xml(@realm_id)
          response = do_http_post(url_for_resource("invoice"), xml)
          if response.code.to_i == 200
            path_to_node = "//xmlns:RestResponse/xmlns:Success/xmlns:#{Quickeebooks::Windows::Model::Invoice::XML_NODE}"
            Quickeebooks::Windows::Model::Invoice.from_xml_ns(response.body, path_to_node)
          else
            nil
          end
        end     
        
        def fetch_by_id(id, params = {:idDomain => 'QB'})
          url = "#{url_for_resource("invoice")}/#{id}"
          response = do_http_get(url, params)
          if response && response.code.to_i == 200
            Quickeebooks::Windows::Model::Invoice.from_xml_ns(response.body)
          else
            nil
          end
        end          

      end
    end
  end
end