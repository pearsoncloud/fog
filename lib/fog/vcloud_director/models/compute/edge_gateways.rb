require 'fog/core/collection'
require 'fog/vcloud_director/models/compute/edge_gateway'

module Fog
  module Compute
    class VcloudDirector

      class EdgeGateways < Collection
        model Fog::Compute::VcloudDirector::EdgeGateway

        identity :id

        attribute :vdc

        private

        def get_by_id(gateway_id)
          gateway = service.get_edge_gateway(gateway_id).body
          service.add_id_from_href!(gateway)
          gateway
        end

        def item_list
          data = service.get_org_vdc_gateways(vdc.id).body
          return [] if data[:EdgeGatewayRecord].empty?
          gateway_references = data[:EdgeGatewayRecord]
          gateway_references.each{|item| service.add_id_from_href!(item) }
          gateway_references
        end
      end
    end
  end
end
