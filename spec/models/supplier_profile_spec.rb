require 'rails_helper'

RSpec.describe SupplierProfile, type: :model do

  before do
    @supplier = build(:supplier)
    @supplier_profile = build(:supplier_profile, supplier: @supplier)
  end

  describe '#create' do
    # representative_name **************************
    it 'representative_nameが空だとNG' do
      @supplier_profile.representative_name = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'representative_nameが30文字以下だとOK' do
      @supplier_profile.representative_name = 'aaaaabbbbbcccccaaaaabbbbbccccc'
      expect(@supplier_profile).to be_valid
    end

    it 'representative_nameが31文字以上だとNG' do
      @supplier_profile.representative_name = 'aaaaabbbbbcccccaaaaabbbbbcccccw'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # representative_kana **************************
    it 'representative_kanaが空だとNG' do
      @supplier_profile.representative_kana = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'representative_kanaが30文字以下だとOK' do
      @supplier_profile.representative_kana = 'aaaaabbbbbcccccaaaaabbbbbccccc'
      expect(@supplier_profile).to be_valid
    end

    it 'representative_kanaが31文字以上だとNG' do
      @supplier_profile.representative_kana = 'aaaaabbbbbcccccaaaaabbbbbcccccw'
      expect(@supplier_profile.valid?).to eq(false)
      # @supplier_profile.valid?
      # expect(@supplier_profile.errors[:representative_kana]).to include("最大30文字まで")
    end

    # manager_name **************************
    it 'manager_nameが空だとNG' do
      @supplier_profile.manager_name = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'manager_nameが30文字以下だとOK' do
      @supplier_profile.manager_name = 'aaaaabbbbbcccccaaaaabbbbbccccc'
      expect(@supplier_profile).to be_valid
    end

    it 'manager_nameが31文字以上だとNG' do
      @supplier_profile.manager_name = 'aaaaabbbbbcccccaaaaabbbbbcccccw'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # manager_name_kana **************************
    it 'manager_name_kanaが空だとNG' do
      @supplier_profile.manager_name_kana = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'manager_name_kanaが30文字以下だとOK' do
      @supplier_profile.manager_name_kana = 'aaaaabbbbbcccccaaaaabbbbbccccc'
      expect(@supplier_profile).to be_valid
    end

    it 'manager_name_kanaが31文字以上だとNG' do
      @supplier_profile.manager_name_kana = 'aaaaabbbbbcccccaaaaabbbbbcccccw'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # prefecture_id **************************
    it 'prefecture_idが空だとNG' do
      @supplier_profile.prefecture_id = nil
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'prefecture_idが1..47の範囲内だとOK' do
      @supplier_profile.prefecture_id = 47
      expect(@supplier_profile).to be_valid
    end

    it 'prefecture_idが1..47の範囲外だとNG' do
      @supplier_profile.prefecture_id = 48
      expect(@supplier_profile.valid?).to eq(false)
    end

    # area_id **************************
    it 'area_idが空だとNG' do
      @supplier_profile.area_id = nil
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'area_idが1..11の範囲内だとOK' do
      @supplier_profile.area_id = 11
      expect(@supplier_profile).to be_valid
    end

    it 'area_idが1..11の範囲外だとNG' do
      @supplier_profile.area_id = 12
      expect(@supplier_profile.valid?).to eq(false)
    end

    # town_id **************************
    it 'town_idが空だとNG' do
      @supplier_profile.town_id = nil
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'town_idが1..179の範囲内だとOK' do
      @supplier_profile.town_id = 179
      expect(@supplier_profile).to be_valid
    end

    it 'town_idが1..179の範囲外だとNG' do
      @supplier_profile.town_id = 180
      expect(@supplier_profile.valid?).to eq(false)
    end

    # detail_address **************************
    it 'detail_addressが空だとNG' do
      @supplier_profile.detail_address = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'detail_addressが100文字以下だとOK' do
      @supplier_profile.detail_address = 'aaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccddddd'
      expect(@supplier_profile).to be_valid
    end

    it 'detail_addressが101文字以上だとNG' do
      @supplier_profile.detail_address = 'aaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddw'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # building **************************
    it 'buildingが空でもOK' do
      @supplier_profile.building = ''
      expect(@supplier_profile).to be_valid
    end

    it 'buildingが100文字以下だとOK' do
      @supplier_profile.building = 'aaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccddddd'
      expect(@supplier_profile).to be_valid
    end

    it 'buildingが101文字以上だとNG' do
      @supplier_profile.building = 'aaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddaaaaabbbbbcccccdddddw'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # post_code **************************
    it 'post_codeが形式通りだとOK' do
      @supplier_profile.post_code = '001-0002'
      expect(@supplier_profile).to be_valid
    end

    it 'post_codeが空だとNG' do
      @supplier_profile.post_code = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'post_codeが形式外だとNG その1　ハイフンなし' do
      @supplier_profile.post_code = '0001111'
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'post_codeが形式外だとNG その2　ハイフン位置が正しくない' do
      @supplier_profile.post_code = '0-001111'
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'post_codeが形式外だとNG その3　半角数字ではない' do
      @supplier_profile.post_code = '001-000１'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # phone **************************
    it 'phoneが形式通りだとOK 10桁' do
      @supplier_profile.phone = '0001112222'
      expect(@supplier_profile).to be_valid
    end

    it 'phoneが形式通りだとOK 11桁' do
      @supplier_profile.phone = '00011112222'
      expect(@supplier_profile).to be_valid
    end

    it 'phoneが空だとNG' do
      @supplier_profile.phone = ''
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その1　ハイフンあり' do
      @supplier_profile.phone = '000-1111-2222'
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その2　半角ではない' do
      @supplier_profile.phone = '００１０００２０００３'
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その3　9桁' do
      @supplier_profile.phone = '000111222'
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その4　12桁' do
      @supplier_profile.phone = '000011112222'
      expect(@supplier_profile.valid?).to eq(false)
    end

    # contract_plan **************************
    it 'contract_planが空だとNG' do
      @supplier_profile.contract_plan = nil
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'contract_planが0..2の範囲内だとOK 2' do
      @supplier_profile.contract_plan = 2
      expect(@supplier_profile).to be_valid
    end

    it 'contract_planが0..2の範囲外だとNG 3' do
      @supplier_profile.contract_plan = 3
      expect(@supplier_profile.valid?).to eq(false)
    end

    # is_suspended **************************
    it 'is_suspendedが空だとNG' do
      @supplier_profile.is_suspended = nil
      expect(@supplier_profile.valid?).to eq(false)
    end

    it 'is_suspendedがtrueだとOK' do
      @supplier_profile.is_suspended = true
      expect(@supplier_profile).to be_valid
    end

    it 'is_suspendedがfalseだとOK' do
      @supplier_profile.is_suspended = false
      expect(@supplier_profile).to be_valid
    end

  end
end
