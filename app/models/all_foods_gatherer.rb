# frozen_string_literal: true

class AllFoodsGatherer
  delegate :foods, to: :user

  def initialize(user:)
    @user = user
  end

  def count
    foods.size
  end

  private

  attr_reader :user
end
