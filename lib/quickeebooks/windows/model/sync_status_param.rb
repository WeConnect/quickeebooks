require "quickeebooks"

module Quickeebooks
  module Windows
    module Model
      class SyncStatusParam < Quickeebooks::Windows::Model::IntuitType

        xml_name 'SyncStatusParam'
        xml_convention :camelcase        
        xml_accessor :id_set, :from => 'IdSet', :as => Quickeebooks::Windows::Model::IdSet
        xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
        xml_accessor :object_type, :from => 'ObjectType'
        xml_accessor :party_id, :from => 'PartyId'

        def initialize(values = {})
          self.ng_id           = values[:ng_id]
          self.object_type     = values[:object_type]
          self.party_id        = values[:party_id]
        end

      end
    end
  end

end