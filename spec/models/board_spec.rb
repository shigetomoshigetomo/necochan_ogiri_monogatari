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
    end
    
    context 'bodyカラム' do
      it '空欄でないこと' do
        book.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        book.body = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        book.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
