module Calculatable
  extend ActiveSupport::Concern

  included do
    def total_amount
      sum = 0
      line_items.each do |line_item|
        sum += line_item.total_price
      end
      sum
    end
  end

end
