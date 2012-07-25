# coding: utf-8
require 'spec_helper'

describe SessionsController do
  let!(:user) { User.create!(name: 'akiinyo') }

  describe 'side jacking protection' do
    before do
      post :create, name: user.name
    end

    specify do
      cookies.signed[:secure_me].should == "secure\##{user.id}"
    end
  end

  describe 'destroy' do
    before do
      controller.me = user
      delete :destroy, {id: user.id}
    end

    specify 'meがいなくなること' do
      controller.me?.should be_false
    end

    specify 'トップページへリダイレクトされること' do
      response.should redirect_to(root_url)
    end
  end
end
