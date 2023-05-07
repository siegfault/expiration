# frozen_string_literal: true

require 'rails_helper'

describe ExpiringFoodsGatherer do
  let(:gatherer) { described_class.new(user: my_user) }
  let!(:other_user_food) { create(:food) }

  context 'when the user has two expiring foods and one non expiring food' do
    let(:my_user) { create(:user, foods: [*expiring, trashed]) }
    let(:expiring) { create_list(:food, 2, :expiring) }
    let(:trashed) { create(:food, :trashed) }

    describe '#foods' do
      let(:foods) { gatherer.foods }

      it "includes the user's expiring foods" do
        expect(foods).to match_array(expiring)
      end

      it "does not include the user's other foods" do
        expect(foods).not_to include(trashed)
      end

      it "does not include another user's foods" do
        expect(foods).not_to include(other_user_food)
      end
    end

    describe '#count' do
      specify { expect(gatherer.count).to eq(2) }
    end
  end
end
