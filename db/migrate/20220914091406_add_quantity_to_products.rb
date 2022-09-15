# frozen_string_literal: true

class AddQuantityToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :quantity, :integer
    add_column :products, :integer, :string
  end
end
