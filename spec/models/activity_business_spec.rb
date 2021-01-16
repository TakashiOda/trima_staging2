require 'rails_helper'

RSpec.describe ActivityBusiness, type: :model do

  before do
    @supplier = build(:supplier)
    @activity_business = build(:activity_business, supplier: @supplier)
  end

  describe '#create' do
    # name **************************
    it 'nameが空だとNG' do
      @activity_business.name = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it 'nameが2文字以上だとOK' do
      @activity_business.name = 'aa'
      expect(@activity_business).to be_valid
    end

    it 'nameが1文字以下だとNG' do
      @activity_business.name = 'a'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'nameが40文字以下だとOK' do
      st = (0...40).map{ (65 + rand(26)).chr }.join
      @activity_business.name = st
      expect(@activity_business).to be_valid
    end

    it 'nameが41文字以上だとNG' do
      st = (0...41).map{ (65 + rand(26)).chr }.join
      @activity_business.name = st
      expect(@activity_business.valid?).to eq(false)
    end

    # en_name **************************
    it 'en_nameが空でもOK' do
      @activity_business.en_name = ''
      expect(@activity_business).to be_valid
    end

    it 'en_nameが2文字以上だとOK' do
      @activity_business.en_name = 'aa'
      expect(@activity_business).to be_valid
    end

    it 'en_nameが1文字以下だとNG' do
      @activity_business.en_name = 'a'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'en_nameが40文字以下だとOK' do
      st = (0...40).map{ (65 + rand(26)).chr }.join
      @activity_business.en_name = st
      expect(@activity_business).to be_valid
    end

    it 'en_nameが41文字以上だとNG' do
      st = (0...41).map{ (65 + rand(26)).chr }.join
      @activity_business.en_name = st
      expect(@activity_business.valid?).to eq(false)
    end

    # cn_name **************************
    it 'cn_nameが空でもOK' do
      @activity_business.cn_name = ''
      expect(@activity_business).to be_valid
    end

    it 'cn_nameが2文字以上だとOK' do
      @activity_business.cn_name = 'aa'
      expect(@activity_business).to be_valid
    end

    it 'cn_nameが1文字以下だとNG' do
      @activity_business.cn_name = 'a'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'cn_nameが40文字以下だとOK' do
      st = (0...40).map{ (65 + rand(26)).chr }.join
      @activity_business.cn_name = st
      expect(@activity_business).to be_valid
    end

    it 'cn_nameが41文字以上だとNG' do
      st = (0...41).map{ (65 + rand(26)).chr }.join
      @activity_business.cn_name = st
      expect(@activity_business.valid?).to eq(false)
    end

    # tw_name **************************
    it 'tw_nameが空でもOK' do
      @activity_business.tw_name = ''
      expect(@activity_business).to be_valid
    end

    it 'tw_nameが2文字以上だとOK' do
      @activity_business.tw_name = 'aa'
      expect(@activity_business).to be_valid
    end

    it 'tw_nameが1文字以下だとNG' do
      @activity_business.tw_name = 'a'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'tw_nameが40文字以下だとOK' do
      st = (0...40).map{ (65 + rand(26)).chr }.join
      @activity_business.tw_name = st
      expect(@activity_business).to be_valid
    end

    it 'tw_nameが41文字以上だとNG' do
      st = (0...41).map{ (65 + rand(26)).chr }.join
      @activity_business.tw_name = st
      expect(@activity_business.valid?).to eq(false)
    end

    # profile_text **************************
    it 'profile_textが空だとNG' do
      @activity_business.profile_text = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it 'profile_textが5文字以上だとOK' do
      @activity_business.profile_text = 'aaaaa'
      expect(@activity_business).to be_valid
    end

    it 'profile_textが4文字以下だとNG' do
      @activity_business.profile_text = 'aaaa'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'profile_textが300文字以下だとOK' do
      st = (0...300).map{ (65 + rand(26)).chr }.join
      @activity_business.profile_text = st
      expect(@activity_business).to be_valid
    end

    it 'profile_textが301文字以上だとNG' do
      st = (0...301).map{ (65 + rand(26)).chr }.join
      @activity_business.profile_text = st
      expect(@activity_business.valid?).to eq(false)
    end

    # en_profile_text **************************
    it 'en_profile_textが空でもOK' do
      @activity_business.en_profile_text = ''
      expect(@activity_business).to be_valid
    end

    it 'en_profile_textが5文字以上だとOK' do
      @activity_business.en_profile_text = 'aaaaa'
      expect(@activity_business).to be_valid
    end

    it 'en_profile_textが4文字以下だとNG' do
      @activity_business.en_profile_text = 'aaaa'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'en_profile_textが300文字以下だとOK' do
      st = (0...300).map{ (65 + rand(26)).chr }.join
      @activity_business.en_profile_text = st
      expect(@activity_business).to be_valid
    end

    it 'en_profile_textが301文字以上だとNG' do
      st = (0...301).map{ (65 + rand(26)).chr }.join
      @activity_business.en_profile_text = st
      expect(@activity_business.valid?).to eq(false)
    end

    # cn_profile_text **************************
    it 'cn_profile_textが空でもOK' do
      @activity_business.cn_profile_text = ''
      expect(@activity_business).to be_valid
    end

    it 'cn_profile_textが5文字以上だとOK' do
      @activity_business.cn_profile_text = 'aaaaa'
      expect(@activity_business).to be_valid
    end

    it 'cn_profile_textが4文字以下だとNG' do
      @activity_business.cn_profile_text = 'aaaa'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'cn_profile_textが300文字以下だとOK' do
      st = (0...300).map{ (65 + rand(26)).chr }.join
      @activity_business.cn_profile_text = st
      expect(@activity_business).to be_valid
    end

    it 'cn_profile_textが301文字以上だとNG' do
      st = (0...301).map{ (65 + rand(26)).chr }.join
      @activity_business.cn_profile_text = st
      expect(@activity_business.valid?).to eq(false)
    end

    # tw_profile_text **************************
    it 'tw_profile_textが空でもOK' do
      @activity_business.tw_profile_text = ''
      expect(@activity_business).to be_valid
    end

    it 'tw_profile_textが5文字以上だとOK' do
      @activity_business.tw_profile_text = 'aaaaa'
      expect(@activity_business).to be_valid
    end

    it 'tw_profile_textが4文字以下だとNG' do
      @activity_business.tw_profile_text = 'aaaa'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'tw_profile_textが300文字以下だとOK' do
      st = (0...300).map{ (65 + rand(26)).chr }.join
      @activity_business.tw_profile_text = st
      expect(@activity_business).to be_valid
    end

    it 'tw_profile_textが301文字以上だとNG' do
      st = (0...301).map{ (65 + rand(26)).chr }.join
      @activity_business.tw_profile_text = st
      expect(@activity_business.valid?).to eq(false)
    end

    # apply_suuplier_address **************************
    it 'apply_suuplier_addressが空だとNG' do
      @activity_business.apply_suuplier_address = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_addressがtrueだとOK' do
      @activity_business.apply_suuplier_address = true
      expect(@activity_business).to be_valid
    end

    it 'apply_suuplier_addressがfalseだとOK' do
      @activity_business.apply_suuplier_address = false
      expect(@activity_business).to be_valid
    end

    # apply_suuplier_phone **************************
    it 'apply_suuplier_phoneが空だとNG' do
      @activity_business.apply_suuplier_phone = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_phoneがtrueだとOK' do
      @activity_business.apply_suuplier_phone = true
      expect(@activity_business).to be_valid
    end

    it 'apply_suuplier_phoneがfalseだとOK' do
      @activity_business.apply_suuplier_phone = false
      expect(@activity_business).to be_valid
    end

    # post_code **************************
    it 'post_codeが形式通りだとOK' do
      @activity_business.post_code = '001-0002'
      expect(@activity_business).to be_valid
    end

    it 'apply_suuplier_address:falseの場合はpost_codeが空だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.post_code = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_address:trueの場合はpost_codeが空でもOK' do
      @activity_business.apply_suuplier_address = true
      @activity_business.post_code = ''
      expect(@activity_business).to be_valid
    end

    it 'apply_suuplier_address:falseの場合はpost_codeが空だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.post_code = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it '（apply_suuplier_addressがfalseの場合）post_codeが形式外だとNG その1　ハイフンなし' do
      @activity_business.apply_suuplier_address = false
      @activity_business.post_code = '0001111'
      expect(@activity_business.valid?).to eq(false)
    end

    it '（apply_suuplier_addressがfalseの場合）post_codeが形式外だとNG その2　ハイフン位置が正しくない' do
      @activity_business.apply_suuplier_address = false
      @activity_business.post_code = '0-001111'
      expect(@activity_business.valid?).to eq(false)
    end

    it '（apply_suuplier_addressがfalseの場合）post_codeが形式外だとNG その3　半角数字ではない' do
      @activity_business.apply_suuplier_address = false
      @activity_business.post_code = '001-000１'
      expect(@activity_business.valid?).to eq(false)
    end

    # phone **************************
    it 'phoneが形式通りだとOK 10桁' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = '0001112222'
      expect(@activity_business).to be_valid
    end

    it 'phoneが形式通りだとOK 11桁' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = '00011112222'
      expect(@activity_business).to be_valid
    end

    it 'phoneが空だとNG' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その1　ハイフンあり' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = '000-1111-2222'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その2　半角ではない' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = '００１０００２０００３'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その3　9桁' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = '000111222'
      expect(@activity_business.valid?).to eq(false)
    end

    it 'phoneが形式外だとNG その4　12桁' do
      @activity_business.apply_suuplier_phone = false
      @activity_business.phone = '000011112222'
      expect(@activity_business.valid?).to eq(false)
    end


    # prefecture_id **************************
    it 'apply_suuplier_address:falseの場合はprefecture_idが空だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.prefecture_id = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_address:trueの場合はprefecture_idが空でもOK' do
      @activity_business.apply_suuplier_address = true
      @activity_business.prefecture_id = nil
      expect(@activity_business).to be_valid
    end

    it 'prefecture_idが1..47の範囲内だとOK' do
      @activity_business.prefecture_id = 47
      expect(@activity_business).to be_valid
    end

    it 'prefecture_idが1..47の範囲外だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.prefecture_id = 48
      expect(@activity_business.valid?).to eq(false)
    end

    # area_id **************************
    it 'apply_suuplier_address:falseの場合はarea_idが空だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.area_id = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_address:trueの場合はarea_idが空でもOK' do
      @activity_business.apply_suuplier_address = true
      @activity_business.area_id = nil
      expect(@activity_business).to be_valid
    end

    it 'area_idが1..11の範囲内だとOK' do
      @activity_business.apply_suuplier_address = false
      @activity_business.area_id = 11
      expect(@activity_business).to be_valid
    end

    it 'area_idが1..11の範囲外だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.area_id = 12
      expect(@activity_business.valid?).to eq(false)
    end

    # town_id **************************
    it 'apply_suuplier_address:falseの場合はtown_idが空だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.town_id = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_address:trueの場合はtown_idが空でもOK' do
      @activity_business.apply_suuplier_address = true
      @activity_business.town_id = nil
      expect(@activity_business).to be_valid
    end

    it 'town_idが1..179の範囲内だとOK' do
      @activity_business.apply_suuplier_address = false
      @activity_business.town_id = 179
      expect(@activity_business).to be_valid
    end

    it 'town_idが1..179の範囲外だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.town_id = 180
      expect(@activity_business.valid?).to eq(false)
    end

    # detail_address **************************
    it 'apply_suuplier_address:falseの場合はdetail_addressが空だとNG' do
      @activity_business.apply_suuplier_address = false
      @activity_business.detail_address = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it 'apply_suuplier_address:trueの場合はdetail_addressが空でもOK' do
      @activity_business.apply_suuplier_address = true
      @activity_business.detail_address = ''
      expect(@activity_business).to be_valid
    end

    it 'detail_addressが100文字以下だとOK' do
      @activity_business.apply_suuplier_address = false
      st = (0...100).map{ (65 + rand(26)).chr }.join
      @activity_business.detail_address = st
      expect(@activity_business).to be_valid
    end

    it 'detail_addressが101文字以上だとNG' do
      @activity_business.apply_suuplier_address = false
      st = (0...101).map{ (65 + rand(26)).chr }.join
      @activity_business.detail_address = st
      expect(@activity_business.valid?).to eq(false)
    end

    # building **************************
    it 'buildingが空でもOK' do
      @activity_business.apply_suuplier_address = false
      @activity_business.building = ''
      expect(@activity_business).to be_valid
    end

    it 'buildingが100文字以下だとOK' do
      @activity_business.apply_suuplier_address = false
      st = (0...100).map{ (65 + rand(26)).chr }.join
      @activity_business.building = st
      expect(@activity_business).to be_valid
    end

    it 'buildingが101文字以上だとNG' do
      @activity_business.apply_suuplier_address = false
      st = (0...101).map{ (65 + rand(26)).chr }.join
      @activity_business.building = st
      expect(@activity_business.valid?).to eq(false)
    end


    # no_charge_cansel_before **************************
    it 'no_charge_cansel_beforeが空だとNG' do
      @activity_business.no_charge_cansel_before = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'no_charge_cansel_beforeが the_day_before だとOK' do
      @activity_business.no_charge_cansel_before = 'the_day_before'
      expect(@activity_business).to be_valid
    end

    it 'no_charge_cansel_beforeが three_days_before だとOK' do
      @activity_business.no_charge_cansel_before = 'three_days_before'
      expect(@activity_business).to be_valid
    end

    it 'no_charge_cansel_beforeが three_days_before だとOK' do
      @activity_business.no_charge_cansel_before = 'a_week_before'
      expect(@activity_business).to be_valid
    end

    it 'no_charge_cansel_beforeが配列外だとNG' do
      @activity_business.no_charge_cansel_before = 'this_is_wrong!'
      expect(@activity_business.valid?).to eq(false)
    end

    # status **************************
    it 'statusが空だとNG' do
      @activity_business.status = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'statusが inputing だとOK' do
      @activity_business.status = 'inputing'
      expect(@activity_business).to be_valid
    end

    it 'statusが send_approve だとOK' do
      @activity_business.status = 'send_approve'
      expect(@activity_business).to be_valid
    end

    it 'statusが配列外だとNG' do
      @activity_business.status = 'this_is_wrong!'
      expect(@activity_business.valid?).to eq(false)
    end


    # guide_certification **************************
    it 'guide_certificationが空でもOK' do
      @activity_business.guide_certification = ''
      expect(@activity_business).to be_valid
    end

    it 'guide_certificationが100文字以下だとOK' do
      st = (0...100).map{ (65 + rand(26)).chr }.join
      @activity_business.guide_certification = st
      expect(@activity_business).to be_valid
    end

    it 'guide_certificationが101文字以上だとNG' do
      st = (0...101).map{ (65 + rand(26)).chr }.join
      @activity_business.guide_certification = st
      expect(@activity_business.valid?).to eq(false)
    end

    # has_insurance **************************
    it 'has_insuranceが空だとNG' do
      @activity_business.has_insurance = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'has_insuranceがtrueだとOK' do
      @activity_business.has_insurance = true
      expect(@activity_business).to be_valid
    end

    it 'has_insuranceがfalseだとOK' do
      @activity_business.has_insurance = false
      expect(@activity_business).to be_valid
    end

    # is_approved **************************
    it 'is_approvedが空だとNG' do
      @activity_business.is_approved = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it 'is_approvedがtrueだとOK' do
      @activity_business.is_approved = true
      expect(@activity_business).to be_valid
    end

    it 'is_approvedがfalseだとOK' do
      @activity_business.is_approved = false
      expect(@activity_business).to be_valid
    end

    # Guide name**************************
    it 'ガイド名が空だとNG' do
      @guide = @activity_business.guides[0]
      @guide.name = ''
      expect(@activity_business.valid?).to eq(false)
    end

    it 'ガイド名が40文字以下だとOK' do
      @guide = @activity_business.guides[0]
      st = (0...40).map{ (65 + rand(26)).chr }.join
      @guide.name = st
      expect(@activity_business).to be_valid
    end

    it 'ガイド名が41文字以上だとNG' do
      @guide = @activity_business.guides[0]
      st = (0...41).map{ (65 + rand(26)).chr }.join
      @guide.name = st
      expect(@activity_business.valid?).to eq(false)
    end

    # Guide roll**************************
    it 'ガイド担当が100文字以下だとOK' do
      @guide = @activity_business.guides[0]
      st = (0...100).map{ (65 + rand(26)).chr }.join
      @guide.roll = st
      expect(@activity_business).to be_valid
    end

    it 'ガイド担当が101文字以上だとNG' do
      @guide = @activity_business.guides[0]
      st = (0...101).map{ (65 + rand(26)).chr }.join
      @guide.roll = st
      expect(@activity_business.valid?).to eq(false)
    end

    # Guide introduction**************************
    it 'ガイド紹介文が200文字以下だとOK' do
      @guide = @activity_business.guides[0]
      st = (0...200).map{ (65 + rand(26)).chr }.join
      @guide.introduction = st
      expect(@activity_business).to be_valid
    end

    it 'ガイド紹介文が201文字以上だとNG' do
      @guide = @activity_business.guides[0]
      st = (0...201).map{ (65 + rand(26)).chr }.join
      @guide.introduction = st
      expect(@activity_business.valid?).to eq(false)
    end

    # 対応可能言語**************************
    it '対応可能言語 言語IDが空だとNG' do
      @activity_language = @activity_business.activity_languages[0]
      @activity_language.language_id = nil
      expect(@activity_business.valid?).to eq(false)
    end

    it '対応可能言語 言語IDが0だとNG' do
      @activity_language = @activity_business.activity_languages[0]
      @activity_language.language_id = 0
      expect(@activity_business.valid?).to eq(false)
    end
    it '対応可能言語 言語IDが29だとNG' do
      @activity_language = @activity_business.activity_languages[0]
      @activity_language.language_id = 29
      expect(@activity_business.valid?).to eq(false)
    end
    it '対応可能言語 言語IDが1だとOK' do
      @activity_language = @activity_business.activity_languages[0]
      @activity_language.language_id = 1
      expect(@activity_business).to be_valid
    end

    it '対応可能言語 言語IDが28だとOK' do
      @activity_language = @activity_business.activity_languages[0]
      @activity_language.language_id = 28
      expect(@activity_business).to be_valid
    end

  end
end
