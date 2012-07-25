# coding: utf-8
require 'spec_helper'

describe SessionsController do
  let!(:user) { User.create!(name: 'akiinyo') }

  describe 'side jacking protection' do
    context 'me=(user)' do
      before { post :create, name: user.name }

      specify do
        cookies.signed[:secure_me].should be_nil
      end
    end

    context 'secure_me=(user)' do
      before do
        post :create, name: user.name
        controller.secure_me = user
      end

      specify do
        cookies.signed[:secure_me].should == "secure\##{user.id}"
      end
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
