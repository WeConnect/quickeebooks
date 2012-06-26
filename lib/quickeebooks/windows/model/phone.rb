require "quickeebooks"

module Quickeebooks
  module Windows
    module Model
      class Phone < Quickeebooks::Windows::Model::IntuitType
        xml_reader   :id_domain, :in => 'Id', :from => "@idDomain"
        xml_accessor :id, :from => 'Id'
        xml_accessor :device_type, :from => 'DeviceType'
        xml_accessor :free_form_number, :from => 'FreeFormNumber'
        xml_accessor :tag, :from => 'Tag'
        xml_accessor :default, :from => 'Default'
        
        def default?
          default == "1"
        end
        
        def initialize(values={})
          self.device_type      = values[:device_type] || "Mobile" 
          self.free_form_number = values[:free_form_number]
          self.tag              = values[:tag] || "Business"
          self.default          = values[:default] ? 1 : 0          
        end
        
      end
    end
  end
end