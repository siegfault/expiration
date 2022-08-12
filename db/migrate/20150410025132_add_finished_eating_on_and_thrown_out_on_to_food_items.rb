# frozen_string_literal: true

class AddFinishedEatingOnAndThrownOutOnToFoodItems < ActiveRecord::Migration
  def change
    add_column :food_items, :finished_eating_on, :date # rubocop:todo Rails/BulkChangeTable
    add_column :food_items, :thrown_out_on, :date
  end
end
