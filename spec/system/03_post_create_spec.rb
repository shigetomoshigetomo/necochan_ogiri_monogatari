require 'rails_helper'

describe '答えの投稿テスト' do
  let!(:member) { create(:member) }
  let!(:board) { create(:board) }

  before do
    load Rails.root.join("db/seeds.rb")
    visit new_member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_button 'ログイン'
  end

  context '答え投稿成功のテスト' do
    before do
      visit board_path(board)
      fill_in 'post[content]', with: Faker::Lorem.characters(number: 30)
      attach_file 'post[image]', File.join(Rails.root, 'spec/fixtures/cheese.jpg')
    end

    it '自分の新しい答えが正しく保存される' do
      expect { click_button '送信' }.to change(member.posts, :count).by(1)
    end

    it 'リダイレクト先が、答えを投稿したお題の詳細画面になっている' do
      click_button '送信'
      expect(current_path).to eq '/boards/' + board.id.to_s
    end
  end

  context '答え投稿失敗のテスト：答えを空の状態で送信' do
    before do
      visit board_path(board)
      fill_in 'post[content]', with: ''
    end

    it '自分の新しいお題が保存されない' do
      expect { click_button '送信' }.not_to change(member.posts, :count)
    end

    it 'バリデーションエラーが表示される' do
      click_button '送信'
      expect(page).to have_content "答えを入力してください"
    end
  end

   context '答え投稿失敗のテスト：答えを101文字で送信' do
    before do
      visit board_path(board)
      @content = Faker::Lorem.characters(number: 101)
      fill_in 'post[content]', with: @content
    end

    it '自分の新しい答えが保存されない' do
      expect { click_button '送信' }.not_to change(member.posts, :count)
    end

    it '新規投稿フォームの内容が正しい' do
      expect(page).to have_field 'post[content]', with: @content
    end

    it 'バリデーションエラーが表示される' do
      click_button '送信'
      expect(page).to have_content "答えは100文字以内で入力してください"
    end
  end
end