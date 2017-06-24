# frozen_string_literal: true

class TrashedFoodItemsGatherer
  def initialize(user:)
    @user = user
  end

  def foods
    user.foods.trashed
  end

  def count
    foods.count
  end

  private
  attr_reader :user
end
