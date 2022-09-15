# frozen_string_literal: true

class ChangeQuantityToBeIntegerInProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :quantity, :integer, using: 'quantity::integer'
  end
end
