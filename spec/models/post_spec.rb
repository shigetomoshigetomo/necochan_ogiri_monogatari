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

  describe 'メソッドのテスト' do
    let!(:member) { create(:member) }
    let!(:other_member) { create(:member) }
    let!(:post) { create(:post, member_id: member.id) }

    context 'いいねの確認' do
      it 'memberが投稿をを既にいいねしてなければfalse' do
        post.favorited_by?(member)
        expect(false).to be_falsey
      end
    end

    context 'よくないねの確認' do
      it 'memberが投稿をを既によくないねしてなければfalse' do
        post.unliked_by?(member)
        expect(false).to be_falsey
      end
    end

    context 'いいね通知作成' do
      it 'other_memberがmemberの答えにいいねすると通知が作成される' do
        other_member.favorites.create(post_id: post.id)
        post.create_notification_like!(other_member)
        expect(member.passive_notifications.where('visitor_id = ? and action = ?', other_member.id, 'like')).to exist
      end
    end
  end
end
