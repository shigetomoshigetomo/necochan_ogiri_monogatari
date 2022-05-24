require 'rails_helper'

describe '管理者側のテスト' do
  let!(:admin) { create(:admin) }

  describe '管理者ログインのテスト' do
     before do
      visit new_admin_session_path
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、通報一覧画面になっている' do
        expect(current_path).to eq '/admin/reports'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end

  describe '管理者ログアウトのテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    context '管理者ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、管理者ログイン画面になっている' do
        click_on "ログアウト"
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end

  describe 'アイテム登録のテスト' do
    before do
      load Rails.root.join("db/seeds.rb")
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    context 'アイテム登録成功のテスト' do
      before do
        visit new_admin_item_path
        attach_file 'item[image]', File.join(Rails.root, 'spec/fixtures/cheese.jpg')
        fill_in 'item[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'item[introduction]', with: Faker::Lorem.characters(number: 10)
        select '武器屋', from: 'item[genre_id]'
        fill_in 'item[price]', with: 5
        fill_in 'item[having_exp]', with: 5
      end

      it '新しいアイテムが正しく保存される' do
        expect { click_button '新規登録' }.to change(Item, :count).by(1)
      end

      it 'リダイレクト先が、ジャンル一覧画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/admin/items/' + Item.last.id.to_s
      end
    end

    context 'アイテム登録失敗のテスト：名前を空の状態で送信する' do
      before do
        visit new_admin_item_path
        attach_file 'item[image]', File.join(Rails.root, 'spec/fixtures/cheese.jpg')
        fill_in 'item[name]', with: ''
        fill_in 'item[introduction]', with: Faker::Lorem.characters(number: 10)
        select '武器屋', from: 'item[genre_id]'
        fill_in 'item[price]', with: 5
        fill_in 'item[having_exp]', with: 5
      end

      it '新しいアイテムが保存されない' do
        expect { click_button '新規登録' }.not_to change(Item.all, :count)
      end

      it 'バリデーションエラーが表示される' do
        click_button '新規登録'
        expect(page).to have_content "アイテム名を入力してください"
      end
    end
  end
end