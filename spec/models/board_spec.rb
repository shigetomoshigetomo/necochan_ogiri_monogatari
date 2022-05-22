require 'rails_helper'

RSpec.describe 'Boardモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { board.valid? }

    let(:member) { create(:member) }
    let!(:board) { build(:board, member_id: member.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        board.title = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は〇' do
        board.title = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        board.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Memberモデルとの関係' do
      it 'N:1となっている' do
        expect(Board.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end
  end
end
