require 'fog/core/model'

module Fog
  module Compute
    class VcloudDirector

      class EdgeGateway < Model

        identity  :id

        attribute :name
        attribute :href
        attribute :displayname, :aliases => :DisplayName
        attribute :interfaces, :aliases => :GatewayInterfaces, :squash => :Configuration

      end
    end
  end
end
