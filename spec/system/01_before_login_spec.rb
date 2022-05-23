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
      expect { click_button '登録' }.to change(Member.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
      click_button '登録'
      expect(current_path).to eq '/about_before'
    end
  end
end

 describe 'ユーザログイン' do
  let(:member) { create(:member) }

  before do
    visit new_member_session_path
  end

  context 'ログイン成功のテスト' do
    before do
      fill_in 'member[email]', with: member.email
      fill_in 'member[password]', with: member.password
      click_button 'ログイン'
    end

    it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
      expect(current_path).to eq '/boards'
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      fill_in 'member[email]', with: ''
      fill_in 'member[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/members/sign_in'
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:member) { create(:member) }

    before do
      visit new_member_session_path
      fill_in 'member[email]', with: member.name
      fill_in 'member[password]', with: member.password
      click_button 'ログイン'
      find(".dropdown-toggle").click
      logout_link = have_link 'ログアウト', href: destroy_member_session_path
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end