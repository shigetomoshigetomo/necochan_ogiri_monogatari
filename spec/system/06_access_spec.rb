require 'rails_helper'

describe 'アクセス制限のテスト' do
  let!(:member) { create(:member) }
  let!(:other_member) { create(:member) }
  let!(:admin) { create(:admin) }
  let!(:board) { create(:board) }
  let!(:post) { create(:post, board: board) }

  before do
    load Rails.root.join("db/seeds.rb")
  end

  describe '[会員側]ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
    subject { current_path }

    it '会員一覧画面' do
      visit members_path
      is_expected.to eq '/members/sign_in'
    end
    it '会員詳細画面' do
      visit member_path(member)
      is_expected.to eq '/members/sign_in'
    end
    it '会員情報編集画面' do
      visit edit_member_path(member)
      is_expected.to eq '/members/sign_in'
    end
    it 'お題一覧画面' do
      visit boards_path
      is_expected.to eq '/members/sign_in'
    end
    it 'お題詳細画面' do
      visit board_path(board)
      is_expected.to eq '/members/sign_in'
    end
    it 'お題新規画面' do
      visit new_board_path
      is_expected.to eq '/members/sign_in'
    end
    it '答え一覧画面' do
      visit posts_index_path
      is_expected.to eq '/members/sign_in'
    end
    it '答え詳細画面' do
      visit board_post_path(board, post)
      is_expected.to eq '/members/sign_in'
    end
    it '検索結果画面' do
      visit search_path
      is_expected.to eq '/members/sign_in'
    end
    it 'お知らせ画面' do
      visit member_notifications_path(member)
      is_expected.to eq '/members/sign_in'
    end
    it 'お買い物画面' do
      visit items_path
      is_expected.to eq '/members/sign_in'
    end
    it 'お買い物画面' do
      visit item_path(Item.find(1))
      is_expected.to eq '/members/sign_in'
    end
    it 'お買い物履歴画面' do
      visit member_shoppings_path(member)
      is_expected.to eq '/members/sign_in'
    end
    it 'お気に入り画面' do
      visit member_my_favorites_path(member)
      is_expected.to eq '/members/sign_in'
    end
    it '会員の友達一覧画面' do
      visit member_friends_path(member)
      is_expected.to eq '/members/sign_in'
    end
    it '通報画面' do
      visit new_member_report_path(member)
      is_expected.to eq '/members/sign_in'
    end
  end

  describe '[管理者側]ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
    subject { current_path }

    it '通報一覧画面' do
      visit admin_reports_path
      is_expected.to eq '/admin/sign_in'
    end
    it '通報詳細画面' do
      visit admin_report_path(Report.find(1))
      is_expected.to eq '/admin/sign_in'
    end
    it '会員一覧画面' do
      visit admin_members_path
      is_expected.to eq '/admin/sign_in'
    end
    it '会員詳細画面' do
      visit admin_member_path(member)
      is_expected.to eq '/admin/sign_in'
    end
    it '会員編集画面' do
      visit edit_admin_member_path(member)
      is_expected.to eq '/admin/sign_in'
    end
    it 'アイテム一覧画面' do
      visit admin_items_path
      is_expected.to eq '/admin/sign_in'
    end
    it 'アイテム詳細画面' do
      visit admin_item_path(Item.find(1))
      is_expected.to eq '/admin/sign_in'
    end
    it 'アイテム編集画面' do
      visit edit_admin_item_path(Item.find(1))
      is_expected.to eq '/admin/sign_in'
    end
    it 'アイテム新規登録画面' do
      visit new_admin_item_path
      is_expected.to eq '/admin/sign_in'
    end
    it 'ジャンル一覧画面' do
      visit admin_genres_path
      is_expected.to eq '/admin/sign_in'
    end
    it 'ジャンル編集画面' do
      visit edit_admin_genre_path(Genre.find(1))
      is_expected.to eq '/admin/sign_in'
    end
    it '検索結果画面' do
      visit admin_search_path
      is_expected.to eq '/admin/sign_in'
    end
    it 'お題詳細画面' do
      visit admin_board_path(board)
      is_expected.to eq '/admin/sign_in'
    end
    it '答え詳細画面' do
      visit admin_board_post_path(board, post)
      is_expected.to eq '/admin/sign_in'
    end
  end

  describe '[ゲスト]アクセス制限のテスト: アクセスできず、エラーメッセージが表示される' do
    subject { current_path }
    before do
      visit root_path
      click_on "ゲストログイン"
    end

    it 'お題新規画面' do
      visit boards_path
      click_on "お題を投稿"
      is_expected.to eq '/boards'
      expect(page).to have_content "権限がありません"
    end
    it 'いいねを押す' do
      visit board_post_path(board, post)
      find(".neko a").click
      is_expected.to eq board_post_path(board, post)
      expect(page).to have_content "権限がありません"
    end
    it 'よくないねを押す' do
      visit board_post_path(board, post)
      find(".unchi a").click
      is_expected.to eq board_post_path(board, post)
      expect(page).to have_content "権限がありません"
    end
    it 'フォローボタンを押す' do
      visit members_path
      find_all(".btn-success")[1].click
      is_expected.to eq '/members'
      expect(page).to have_content "権限がありません"
    end
    it 'アイテムの購入ボタンを押す' do
      visit item_path(Item.find(1))
      click_on "購入する"
      is_expected.to eq item_path(Item.find(1))
      expect(page).to have_content "権限がありません"
    end
  end

  describe '他人の画面のテスト' do
    before do
      visit new_member_session_path
      fill_in 'member[email]', with: member.email
      fill_in 'member[password]', with: member.password
      click_button 'ログイン'
    end

    context '他人の会員詳細画面' do
      before do
        visit member_path(other_member)
      end
      it '編集画面へのリンクは存在しない' do
        expect(page).not_to have_link '', href: edit_member_path(other_member)
      end
      it 'お知らせ画面へのリンクは存在しない' do
        expect(page).not_to have_link '', href: member_notifications_path(other_member)
      end
      it '他人の編集画面に遷移できず、自分のユーザ詳細画面にリダイレクトされる' do
        visit edit_member_path(other_member)
        expect(current_path).to eq boards_path
      end
    end
  end
end