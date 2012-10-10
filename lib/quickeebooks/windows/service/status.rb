require 'quickeebooks/windows/service/service_base'
require 'quickeebooks/windows/model/status'
require 'quickeebooks/windows/model/ng_id_set'
require 'quickeebooks/windows/model/sync_status_param'
require 'tempfile'

module Quickeebooks
  module Windows
    module Service
      class Status < Quickeebooks::Windows::Service::ServiceBase    

        def fetch_details(status, errored_objects_only=false)
          xml = status.to_xml_ns(:errored_objects_only => errored_objects_only)
          response = do_http_post(url_for_resource("status"), xml)
          if response && response.code.to_i == 200
            Quickeebooks::Windows::Model::Status.from_xml_ns(response.body)
          else
            nil
          end
        end

      end
    end
  end
end