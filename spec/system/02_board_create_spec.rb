require 'rails_helper'

describe 'お題の投稿テスト' do
  let!(:member) { create(:member) }
  let!(:other_member) { create(:member) }
  let!(:board) { create(:board, member: member) }
  let!(:other_board) { create(:board, member: other_member) }

  before do
    visit new_member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_button 'ログイン'
  end
end