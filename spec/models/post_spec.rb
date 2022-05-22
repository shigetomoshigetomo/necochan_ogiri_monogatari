require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:member) { create(:member) }
    let!(:board) { build(:board, member_id: member.id) }
    let!(:post) { build(:post, board: board) }

    context 'contentカラム' do
      it '空欄でないこと' do
        post.content = ''
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は〇' do
        post.content = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        post.content = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Memberモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end

    context 'Boardモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:board).macro).to eq :belongs_to
      end
    end
  end
end
