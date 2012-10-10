require "quickeebooks"

module Quickeebooks
  module Windows
    module Model
      class NgIdSet < Quickeebooks::Windows::Model::IntuitType

        xml_name 'NgIdSet'
        xml_convention :camelcase        
        xml_accessor :ng_id, :from => 'NgId'
        xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
        xml_accessor :ng_object_type, :from => 'NgObjectType'
        xml_accessor :party_id, :from => 'PartyId'

        def initialize(values = {})
          self.ng_id           = values[:ng_id]
          self.ng_object_type  = values[:ng_object_type]
          self.party_id        = values[:party_id]
        end

      end
    end
  end

end