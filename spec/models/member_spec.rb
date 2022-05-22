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

  describe 'メソッドのテスト' do
    let!(:member) { create(:member) }
    let!(:other_member) { create(:member) }

    context 'ゲストユーザーの作成' do
      it 'ゲストの名前が「ゲスト」、emailが「guest@example.com」になる' do
        guest_member = Member.guest
        expect(guest_member.name).to eq "ゲスト"
        expect(guest_member.email).to eq "guest@example.com"
      end
    end

    context 'フォロー機能' do
      it 'other_memberがmemberをフォローする' do
        other_member.follow(member.id)
        expect(other_member.followings).to include member
        expect(member.followers).to include other_member
      end

      it 'other_memberがmemberのフォローを外す' do
        other_member.follow(member.id)
        other_member.unfollow(member.id)
        expect(other_member.followings).not_to include member
        expect(member.followers).not_to include other_member
      end

      it 'other_memberがmemberをフォローしている' do
        other_member.follow(member.id)
        other_member.following?(member)
        expect(true).to be_truthy
      end
    end

    context 'memberの有効・退会ステータス確認' do
      it 'memberの会員ステータスが有効の場合にfalseを返す' do
        member.active_for_authentication?
        expect(false).to be_falsey
      end
    end

    context 'フォロワー通知作成' do
      it 'other_memberがmemberをフォローすると、通知が作成される' do
        member.create_notification_follow!(other_member)
        expect(member.passive_notifications.where('visitor_id = ? and action = ?', other_member.id, 'follow')).to exist
      end
    end

    context 'マネーを更新' do
      it 'memberのマネーが正しく加算されている' do
        money = 3
        member.add_money(money)
        expect(member.money).to eq 3
      end
    end
  end
end