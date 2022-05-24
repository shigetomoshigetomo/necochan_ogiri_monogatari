require 'rails_helper'

describe '買い物のテスト' do
  let!(:member) { create(:member) }

  before do
    load Rails.root.join("db/seeds.rb")
    visit new_member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_button 'ログイン'
    @test_item_cheap = Item.find(11)
    @test_item_expensive = Item.find(10)
    member.update(:money => 50)
  end

  context '買い物成功のテスト' do
    before do
      visit item_path(@test_item_cheap)
    end

    it '買い物に成功し、注文が保存される' do
      expect { click_button '購入する' }.to change(member.orders, :count).by(1)
    end

    it 'リダイレクト先が、アイテム一覧画面になっている' do
      click_button '購入する'
      expect(current_path).to eq '/items'
    end
  end

  context '買い物失敗のテスト' do
    before do
      visit item_path(@test_item_expensive)
    end

    it '買い物に失敗し、注文が保存されない' do
      expect { click_button '購入する' }.not_to change(member.orders, :count)
    end

    it 'リダイレクト先が、アイテム一覧画面になっている' do
      click_button '購入する'
      expect(current_path).to eq '/items/' + @test_item_expensive.id.to_s
    end
  end

end