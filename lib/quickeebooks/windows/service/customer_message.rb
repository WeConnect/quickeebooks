require 'quickeebooks/windows/service/service_base'
require 'nokogiri'

module Quickeebooks
  module Windows
    module Service
      class CustomerMessage < Quickeebooks::Windows::Service::ServiceBase

        def list(filters = [], page = 1, per_page = 20, sort = nil, options = {})
          fetch_collection("customermsg", "CustomerMsg", Quickeebooks::Windows::Model::CustomerMessage, nil, filters, page, per_page, sort, options)
        end
        

      end
    end
  end
end