require 'rails_helper'

describe 'アクセス制限のテスト' do
  let!(:member) { create(:member) }
  let!(:other_member) { create(:member) }
  let!(:board) { create(:board) }
  let!(:post) { create(:post, board: board) }

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
    it 'お気に入り画面' do
      visit member_my_favorites_path(member)
      is_expected.to eq '/members/sign_in'
    end
  end
end