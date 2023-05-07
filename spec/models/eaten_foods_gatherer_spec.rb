# frozen_string_literal: true

require 'rails_helper'

describe EatenFoodsGatherer do
  let(:gatherer) { described_class.new(user: my_user) }
  let!(:other_user_food) { create(:food) }

  context 'when the user has two expiring foods and one non expiring food' do
    let(:my_user) { create(:user, foods: [*eaten, expiring]) }
    let(:eaten) { create_list(:food, 2, :eaten) }
    let(:expiring) { create(:food, :expiring) }

    describe '#foods' do
      let(:foods) { gatherer.foods }

      it "includes the user's eaten foods" do
        expect(foods).to match_array(eaten)
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
