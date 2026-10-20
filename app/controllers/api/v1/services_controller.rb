module Api
  module V1
    class ServicesController < Api::BaseController
      before_action :authenticate!, only: :create

      def index
        services = services_with_counts.by_name
        render json: services.map { |service| document(service, service.repairs_count) }
      end

      def show
        service = services_with_counts.find(params[:id])
        render json: document(service, service.repairs_count)
      end

      def create
        service = Service.new(service_params)
        if service.save
          render json: document(service, 0), status: :created,
                 location: api_v1_service_url(service)
        else
          render_errors(service.errors.full_messages, :unprocessable_content)
        end
      end

      private

     
      def services_with_counts
        Service.left_joins(:repair_services)
               .select("services.*, COUNT(DISTINCT repair_services.repair_id) AS repairs_count")
               .group("services.id")
      end

      def document(service, repairs_count)
        {
          id: service.id,
          name: service.name,
          price: money(service.price),
          repairs_count: repairs_count
        }
      end

      def service_params
        params.expect(service: %i[name price])
      end
    end
  end
end