# frozen_string_literal: true

class AddColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :sub_total, :decimal
  end
end
