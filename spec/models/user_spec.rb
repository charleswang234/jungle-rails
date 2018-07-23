require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    before :each do
      @user = User.new(first_name: "charles", last_name: "wang", email: "charleswang234@gmail.com", password: "newer", password_confirmation: "newer")
    end

    it "is valid with all valid properties" do
      @user.save
      expect(@user).to be_valid
    end

    it "is not valid without first_name" do
      @user.first_name = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it "is not valid without last_name" do
      @user.last_name = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    it "is not valid without email" do
      @user.email = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it "is not valid without last_name" do
      @user.last_name = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    it "is not valid without password and password confirmation" do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to eq(["Password can't be blank", "Password digest can't be blank"])
    end


    it "is not valid when password and password confirmation don't match" do
      @user = User.new(first_name: "charles", last_name: "wang", email: "charleswang234@gmail.com", password: "newer", password_confirmation: "")
      @user.save
      expect(@user).not_to be_valid
    end

    it "is not valid when an account exists with the same email" do
       @user2 = User.new(first_name: "charles", last_name: "wang", email: "charlesWANG234@gmail.com", password: "newer", password_confirmation: "newer")
       @user2.email.downcase!
      @user2.save
      @user.save
      expect(@user).not_to be_valid
      # expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it "is not valid with password length less than 5 characters" do
       @user = User.new(first_name: "charles", last_name: "wang", email: "charleswang234@gmail.com", password: "new", password_confirmation: "new")
      @user.save
      expect(@user).not_to be_valid
    end
  end


  describe '.authenticate_with_credentials' do
    before :each do
      @user1 = User.new(first_name: "charles", last_name: "wang", email: "charleswang234@gmail.com", password: "newer", password_confirmation: "newer")
      @user1.save
    end

    it "is valid when the email and password are valid" do
      @user2 = User.authenticate_with_credentials("charleswang234@gmail.com", "newer")
      expect(@user2).to eq(@user1)
    end

    it "is not valid when email and password are incorrect" do
      @user2 = User.authenticate_with_credentials("charleswang234@gmail.com", "new")
      expect(@user2).to be_nil
    end

    it "is valid when email is uppercased" do
      @user2 = User.authenticate_with_credentials("CHARLESWANG234@GMAIL.COM", "newer")
       expect(@user2).to eq(@user1)
    end

    it "is valid when email has spaces on the edges" do
      @user2 = User.authenticate_with_credentials(" charleswang234@gmail.com ", "newer")
      expect(@user2).to eq(@user1)
    end
  end





end


# create_table "users", force: :cascade do |t|
#     t.string   "first_name"
#     t.string   "last_name"
#     t.string   "email"
#     t.string   "password_digest"
#     t.datetime "created_at",      null: false
#     t.datetime "updated_at",      null: false
#   end