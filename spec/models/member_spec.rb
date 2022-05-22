require 'rails_helper'

RSpec.describe 'Memberモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { member.valid? }

    let!(:other_member) { create(:member) }
    let(:member) { build(:member) }

    context 'nameカラム' do
      it '空欄でないこと' do
        member.name = ''
        is_expected.to eq false
      end
      it '8文字以下であること: 8文字は〇' do
        member.name = Faker::Lorem.characters(number: 8)
        is_expected.to eq true
      end
      it '8文字以下であること: 9文字は×' do
        member.name = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
      it '一意性があること' do
        member.name = other_member.name
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        member.email = ''
        is_expected.to eq false
      end
      it '255文字以下であること: 255文字は〇' do
        member.email = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
      it '255文字以下であること: 256文字は×' do
        member.email = Faker::Lorem.characters(number: 226)
        is_expected.to eq false
      end
      it '一意性があること' do
        member.email = other_member.email
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Boardモデルとの関係' do
      it '1:Nとなっている' do
        expect(Member.reflect_on_association(:boards).macro).to eq :has_many
      end
    end
  end
end
