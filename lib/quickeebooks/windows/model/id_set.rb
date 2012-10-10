require "quickeebooks"

module Quickeebooks
  module Windows
    module Model
      class IdSet < Quickeebooks::Windows::Model::IntuitType

        xml_name 'IdSet'
        xml_convention :camelcase        
        xml_accessor :id, :from => 'Id', :as => Integer

        def initialize(values = {})
          self.id = values[:id]
        end

      end
    end
  end

end