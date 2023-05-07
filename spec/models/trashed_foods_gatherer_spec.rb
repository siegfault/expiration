# frozen_string_literal: true

require 'rails_helper'

describe TrashedFoodsGatherer do
  let(:gatherer) { described_class.new(user: my_user) }
  let!(:other_user_food) { create(:food) }

  context 'when the user has two trashed foods and one non trashed food' do
    let(:my_user) { create(:user, foods: [expiring, *trashed]) }
    let(:expiring) { create(:food, :expiring) }
    let(:trashed) { create_list(:food, 2, :trashed) }

    describe '#foods' do
      let(:foods) { gatherer.foods }

      it "includes the user's trashed foods" do
        expect(foods).to match_array(trashed)
      end

      it "does not include the user's other foods" do
        expect(foods).not_to include(expiring)
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
