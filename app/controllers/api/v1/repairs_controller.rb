module Api
  module V1
    class RepairsController < Api::BaseController
      before_action :authenticate!

      def index
        repairs = preload(Repair.newest_first)
        repairs = repairs.where(status: requested_state) if params.key?(:state)
        render json: repairs.map { |repair| document(repair) }
      end

      def show
        repair = preload(Repair.all).find(params[:id])
        render json: document(repair)
      end

      private

      def preload(scope)
        scope.includes(bike: :customer, repair_services: :service)
      end

      def requested_state
        state = params[:state].to_s
        return state if Repair.statuses.key?(state)

        raise BadRequest,
              "Unknown state \"#{state}\". Valid states: #{Repair.statuses.keys.join(', ')}"
      end

      def document(repair)
        lines = repair.repair_services.to_a
        {
          id: repair.id,
          state: repair.status,
          received_on: repair.received_at.to_date,
          promised_on: repair.promised_on,
          returned_on: repair.returned_at&.to_date,
          bike: {
            brand: repair.bike.make,
            model: repair.bike.model,
            serial_number: repair.bike.serial_number
          },
          customer: { name: repair.bike.customer.name },
          lines: lines.map do |line|
            { service: line.service.name, price_charged: money(line.charged_price) }
          end,
          total: money(lines.sum(&:charged_price)),
          overdue: repair.overdue?,
          customer_answer: repair.customer_response
        }
      end
    end
  end
end