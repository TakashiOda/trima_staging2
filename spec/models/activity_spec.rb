require 'rails_helper'

RSpec.describe Activity, type: :model do

  before do
    @supplier = create(:supplier)
    @activity_business = create(:activity_business, supplier: @supplier)
    @activity = build(:activity, activity_business: @activity_business)
  end

  describe '#create' do
    # name **************************
    it 'nameが空だとNG' do
      @activity.name = 'aaa'
      expect(@activity.valid?).to eq(false)
    end
  end
end
