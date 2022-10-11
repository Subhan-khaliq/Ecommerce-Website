# frozen_string_literal: true

module LineItemsManager
  class LineItemsReduceQuantity
    def initialize(params)
      @id = params[:id]
    end

    def call
      result = reduce_quantity
    rescue reduce_quantity::Error => e
      OpenStruct.new({ success?: false, error: e })
    else
      OpenStruct.new({ success?: true, payload: result })
    end

    private

    def reduce_quantity
      @line_item = LineItem.find(@id)
      if @line_item.quantity > 1
        @line_item.quantity -= 1
        @line_item.save
      elsif @line_item.quantity == 1
        @line_item.destroy
      end
    end
  end
end
