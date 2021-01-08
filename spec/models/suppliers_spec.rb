require 'rails_helper'

RSpec.describe Supplier, type: :model do

  describe '#create' do
    it 'nameが空でもOK' do
      supplier = build(:supplier, name: '')
      expect(supplier).to be_valid
    end

    it 'nameが20文字以上だとNG' do
      supplier = build(:supplier, name: 'あいうえおかきくけこさしすせそたちつてとな')
      expect(supplier.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      supplier = build(:supplier, email: '')
      expect(supplier.valid?).to eq(false)
    end

    it 'emailが形式外だとNG' do
      supplier = build(:supplier, email: 'ttt@ttt')
      expect(supplier.valid?).to eq(false)
    end

    it 'passwordが空だとNG' do
      supplier = build(:supplier, encrypted_password: '')
      expect(supplier.valid?).to eq(false)
    end

  end

end
