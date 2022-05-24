require 'rails_helper'

describe 'いいねのクリックテスト' do
  let!(:member) { create(:member) }
  let!(:board) { create(:board) }
  let!(:post) { create(:post, board_id: board.id) }

  before do
    load Rails.root.join("db/seeds.rb")
    visit new_member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_button 'ログイン'
    visit board_post_path(board, post)
  end

  context 'いいねする', xhr: true do
    it 'カウントが１つ増え、アイコンのcssが変わる' do
      find('.neko').click
      # expect(page).to have_css '.pink-favorite'
      expect(post.favorites.count).to eq(1)
    end
  end

  # context 'いいねを外す' do
  #   it 'カウントが１つ減り、アイコンのcssが変わる' do
  #     find('.neko').click
  #     expect(page).to have_css '.unfavorite'
  #   end
  # end
end