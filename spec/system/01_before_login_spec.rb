require 'rails_helper'

describe 'ユーザ新規登録のテスト' do
  before do
    visit new_member_registration_path
  end

  context '新規登録成功のテスト' do
    before do
      fill_in 'member[name]', with: Faker::Lorem.characters(number: 8)
      fill_in 'member[email]', with: Faker::Internet.email
      fill_in 'member[password]', with: 'password'
      fill_in 'member[password_confirmation]', with: 'password'
    end

    it '正しく新規登録される' do
      expect { click_button '新規登録（無料）' }.to change(Member.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
      click_button '新規登録（無料）'
      expect(current_path).to eq '/about_before'
    end
  end
end