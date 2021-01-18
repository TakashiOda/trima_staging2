require 'rails_helper'

RSpec.describe Activity, type: :model do

  before do
    @supplier = build(:supplier)
    @activity_business = build(:activity_business, supplier: @supplier)
    # @activity = build(:activity)
    @activity = build(:activity, activity_business: @activity_business)
  end

  describe '#create' do
    # name **************************
    it 'nameが空だとNG' do
      @activity.name = ''
      expect(@activity.valid?).to eq(false)
    end

    it 'nameが41文字だとNG' do
      st = (0...41).map{ (65 + rand(26)).chr }.join
      @activity.name = st
      @activity.valid?
      expect(@activity.errors[:name]).to include("体験名は最大40字までです")
    end

    it 'nameが40文字だとOK' do
      st = (0...40).map{ (65 + rand(26)).chr }.join
      @activity.name = st
      expect(@activity).to be_valid
    end

    # description **************************
    it 'descriptionが空だとNG' do
      @activity.description = ''
      expect(@activity.valid?).to eq(false)
    end

    it 'descriptionが201文字だとNG' do
      st = (0...201).map{ (65 + rand(26)).chr }.join
      @activity.description = st
      @activity.valid?
      expect(@activity.errors[:description]).to include("体験紹介文は最大200字までです")
    end

    it 'descriptionが200文字だとOK' do
      st = (0...200).map{ (65 + rand(26)).chr }.join
      @activity.description = st
      expect(@activity).to be_valid
    end

    # notes **************************
    it 'notesは空でもOK' do
      @activity.notes = ''
      expect(@activity).to be_valid
    end

    it 'notesが501文字だとNG' do
      st = (0...501).map{ (65 + rand(26)).chr }.join
      @activity.notes = st
      @activity.valid?
      expect(@activity.errors[:notes]).to include("注意事項は最大500字までです")
    end

    it 'notesが500文字だとOK' do
      st = (0...500).map{ (65 + rand(26)).chr }.join
      @activity.notes = st
      expect(@activity).to be_valid
    end

    # activity_category_id **************************
    it 'activity_category_idは空だとNG' do
      @activity.activity_category_id = nil
      expect(@activity.valid?).to eq(false)
    end

    it 'activity_category_idが1だとOK' do
      @activity.activity_category_id = 1
      expect(@activity).to be_valid
    end

    it 'activity_category_idが32だとOK' do
      @activity.activity_category_id = 32
      expect(@activity).to be_valid
    end

    it 'activity_category_idが33だとNG' do
      @activity.activity_category_id = 33
      expect(@activity.valid?).to eq(false)
    end
    # available_age **************************
    it 'available_ageは空だとNG' do
      @activity.available_age = nil
      expect(@activity.valid?).to eq(false)
    end

    it 'available_ageが0だとOK' do
      @activity.available_age = 0
      expect(@activity).to be_valid
    end

    it 'available_ageが100だとOK' do
      @activity.available_age = 100
      expect(@activity).to be_valid
    end

    it 'available_ageが101だとNG' do
      @activity.available_age = 101
      expect(@activity.valid?).to eq(false)
    end
    # maximum_num **************************
    it 'maximum_numは空だとNG' do
      @activity.maximum_num = nil
      expect(@activity.valid?).to eq(false)
    end
    it 'maximum_numは0だとNG' do
      @activity.maximum_num = 0
      expect(@activity.valid?).to eq(false)
    end

    it 'maximum_numが50だとOK' do
      @activity.maximum_num = 50
      expect(@activity).to be_valid
    end

    it 'maximum_numが51だとNG' do
      @activity.maximum_num = 51
      expect(@activity.valid?).to eq(false)
    end
    # minimum_num **************************
    it 'minimum_numは空だとNG' do
      @activity.minimum_num = nil
      expect(@activity.valid?).to eq(false)
    end
    it 'minimum_numは0だとNG' do
      @activity.minimum_num = 0
      expect(@activity.valid?).to eq(false)
    end

    it 'minimum_numが50だとOK' do
      @activity.minimum_num = 50
      expect(@activity).to be_valid
    end

    it 'minimum_numが51だとNG' do
      @activity.minimum_num = 51
      expect(@activity.valid?).to eq(false)
    end
    # activity_minutes **************************
    it 'activity_minutesは空だとNG' do
      @activity.activity_minutes = nil
      expect(@activity.valid?).to eq(false)
    end
    it 'activity_minutesは19だとNG' do
      @activity.activity_minutes = 19
      expect(@activity.valid?).to eq(false)
    end

    it 'activity_minutesが20だとOK' do
      @activity.activity_minutes = 20
      expect(@activity).to be_valid
    end
    it 'activity_minutesが480だとOK' do
      @activity.activity_minutes = 480
      expect(@activity).to be_valid
    end

    it 'activity_minutesが481だとNG' do
      @activity.activity_minutes = 481
      expect(@activity.valid?).to eq(false)
    end

    # area_id **************************
    it 'area_idが0だとNG' do
      @activity.area_id = 0
      expect(@activity.valid?).to eq(false)
    end

    it 'area_idが1..11の範囲内だとOK' do
      @activity.area_id = 1
      expect(@activity).to be_valid
    end
    it 'area_idが1..11の範囲内だとOK' do
      @activity.area_id = 11
      expect(@activity).to be_valid
    end

    it 'area_idが1..11の範囲外だとNG' do
      @activity.area_id = 12
      expect(@activity.valid?).to eq(false)
    end

    # town_id **************************
    it 'town_idが0だとNG' do
      @activity.town_id = 0
      expect(@activity.valid?).to eq(false)
    end

    it 'town_idが1..179の範囲内だとOK' do
      @activity.town_id = 1
      expect(@activity).to be_valid
    end
    it 'town_idが1..179の範囲内だとOK' do
      @activity.town_id = 179
      expect(@activity).to be_valid
    end

    it 'town_idが1..179の範囲外だとNG' do
      @activity.town_id = 180
      expect(@activity.valid?).to eq(false)
    end

  end
end
