require 'spec_helper'

describe "Sessions" do
  context "login" do
    context "a nonexisting user" do
      before(:each) do
        FactoryGirl.create(:user, provider:'facebook', uid:'123456')
        @user_count = User.count 
        visit '/auth/facebook' 
        @user = User.last
      end

      it "adds no user to the db" do
        User.count.should eq @user_count
      end
    end

    context "an existing user" do
      before(:each) do
        @user_count = User.count 
        visit '/auth/facebook' 
        @user = User.last
      end

      it "adds a user to the db" do
        User.count.should eq @user_count+1
      end

      it "sets the provider" do
        @user.provider.should eq 'facebook'
      end
      it "sets the uid" do
        @user.uid.should eq '123456'
      end
      it "sets the name" do
        @user.name.should eq 'Test Name'
      end
      it "sets the username" do
        @user.username.should eq 'testuser'
      end
      it "sets the email" do
        @user.email.should eq 'test@user.com'
      end
      it "sets the oauth_token" do
        @user.oauth_token.should eq 'abc123'
      end
      it "sets the oauth_expires_at" do
        @user.oauth_expires_at.should eq Time.at(1341979183)
      end
    end
  end
end
