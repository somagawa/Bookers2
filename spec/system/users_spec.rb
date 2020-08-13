require 'rails_helper'

describe "ユーザー認証のテスト" do
	context "ユーザー新規登録" do
		before do
			visit new_user_registration_path
		end
		it "新規登録に成功する" do
			fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
			fill_in "user[email]", with: Faker::Internet.email
			fill_in "user[password]", with: "password"
			fill_in "user[password_confirmation]", with: "password"
			click_button "Sign up"

			expect(page).to have_content "successfully"
		end
		it "新規登録に失敗する" do
			fill_in "user[name]", with: ""
			fill_in "user[email]", with: ""
			fill_in "user[password]", with: ""
			fill_in "user[password_confirmation]", with: ""
			click_button "Sign up"

			expect(page).to have_content "error"
		end
	end
	context "ユーザーログイン" do
		let(:user) { create(:user) }
		before do
			visit new_user_session_path
		end
		it "ログインに成功する" do
			fill_in "user[name]", with: user.name
			fill_in "user[password]", with: user.password
			click_button "Log in"

			expect(page).to have_content "successfully"
		end
		it "ログインに失敗する" do
			fill_in "user[name]", with: ""
			fill_in "user[password]", with: ""
			click_button "Log in"

			expect(current_path).to eq new_user_session_path
		end
	end
end

describe "ユーザーのテスト" do
	let(:user) { create(:user) }
	let(:user2) { create(:user) }
	before do
		visit new_user_session_path

		fill_in "user[name]", with: user.name
		fill_in "user[password]", with: user.password
		click_button "Log in"
	end
	describe "サイドバーのテスト" do
		context "表示の確認" do
			it "User infoと表示される" do
				expect(page).to have_content "User info"
			end
			it "画像が表示される" do
				expect(page).to have_css "img.profile_image"
			end
			it "名前が表示される" do
				expect(page).to have_content user.name
			end
			it "自己紹介が表示される" do
				expect(page).to have_content user.introduction
			end
			it "編集リンクが表示される" do
				expect(page).to have_link href: edit_user_path(user)
			end
		end
	end
	describe "編集のテスト" do
		before do
			visit edit_user_path(user)
		end
		context "自分の編集画面への遷移" do
			it "遷移できる" do
				expect(current_path).to eq edit_user_path(user)
			end
		end
		context "他人の編集画面への遷移" do
			it "遷移できない" do
				visit edit_user_path(user2)
				expect(current_path).to eq user_path(user)
			end
		end
		context "表示の確認" do
			it "User infoと表示される" do
				expect(page).to have_content "User info"
			end
			it "名前編集フォームに自分の名前が表示される" do
				expect(page).to have_field "user[name]", with: user.name
			end
			it "画像編集フォームが表示される" do
				expect(page).to have_field "user[profile_image]"
			end
			it "自己紹介編集フォームに自分の自己紹介が表示される" do
				expect(page).to have_field "user[introduction]", with: user.introduction
			end
			it "編集に成功する" do
				fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
				fill_in "user[introduction]", with: Faker::Lorem.characters(number: 30)
				click_button "Update User"

				expect(current_path).to eq user_path(user)
				expect(page).to have_content "successfully"
			end
			it "編集に失敗する" do
				fill_in "user[name]", with: ""
				fill_in "user[introduction]", with: ""
				click_button "Update User"

				expect(current_path).to eq user_path(user)
				expect(page).to have_content "error"
			end
		end
	end
end