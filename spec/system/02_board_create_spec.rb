require 'rails_helper'

describe 'お題の投稿テスト' do
  let!(:member) { create(:member) }

  before do
    load Rails.root.join("db/seeds.rb")
    visit new_member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_button 'ログイン'
  end

  context 'お題投稿成功のテスト' do
    before do
      visit new_board_path
      fill_in 'board[title]', with: Faker::Lorem.characters(number: 15)
      attach_file 'board[image]', File.join(Rails.root, 'spec/fixtures/cheese.jpg')
    end

    it '自分の新しいお題が正しく保存される' do
      expect { click_button '送信' }.to change(member.boards, :count).by(1)
    end

    it 'リダイレクト先が、保存できたお題の詳細画面になっている' do
      click_button '送信'
      expect(current_path).to eq '/boards/' + Board.last.id.to_s
    end
  end

  context 'お題投稿失敗のテスト：お題を空の状態で送信' do
    before do
      visit new_board_path
      fill_in 'board[title]', with: ''
    end

    it '自分の新しいお題が保存されない' do
      expect { click_button '送信' }.not_to change(member.boards, :count)
    end

    it 'バリデーションエラーが表示される' do
      click_button '送信'
      expect(page).to have_content "お題を入力してください"
    end
  end

  context 'お題投稿失敗のテスト：お題を51文字で送信' do
    before do
      visit new_board_path
      @title = Faker::Lorem.characters(number: 51)
      fill_in 'board[title]', with: @title
    end

    it '自分の新しいお題が保存されない' do
      expect { click_button '送信' }.not_to change(member.boards, :count)
    end

    it '新規投稿フォームの内容が正しい' do
      expect(page).to have_field 'board[title]', with: @title
    end

    it 'バリデーションエラーが表示される' do
      click_button '送信'
      expect(page).to have_content "お題は50文字以内で入力してください"
    end
  end

end