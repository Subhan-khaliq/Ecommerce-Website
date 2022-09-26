# frozen_string_literal: true

class LineItemsQuantity
  def initialize(params)
    @id = params[:id]
  end

  def call
    result = add_quantity
  rescue add_quantity::Error => e
    OpenStruct.new({ success?: false, error: e })
  else
    OpenStruct.new({ success?: true, payload: result })
  end

  private

  def add_quantity
    @line_item = LineItem.find(@id)
    @line_item.quantity += 1
    @line_item.save
  end
end
