# frozen_string_literal: true

class AddColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :subtotal, :decimal
    add_column :orders, :total, :decimal
  end
end
