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
          return [] if data[:EdgeGatewayReferences].empty?
          gateway_references = data[:EdgeGatewayReferences][:EdgeGatewayReference]
          items = gateway_references.select { |link| link[:type] == "application/vnd.vmware.admin.edgeGateway+xml" }
          items.each{|item| service.add_id_from_href!(item) }
          items
        end
      end
    end
  end
end
