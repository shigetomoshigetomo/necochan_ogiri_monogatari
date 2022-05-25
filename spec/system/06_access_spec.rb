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
end