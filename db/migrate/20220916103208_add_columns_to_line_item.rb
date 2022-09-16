# frozen_string_literal: true

class AddColumnsToLineItem < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :total, :decimal
    add_column :line_items, :unit_price, :decimal
  end
end
