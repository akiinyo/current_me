# coding: utf-8
require 'spec_helper'

describe SessionsController do
  let!(:user) { User.create!(name: 'akiinyo') }

  describe 'destroy' do
    before {
      controller.me = user
      delete :destroy, {id: user.id}
    }

    specify 'meがいなくなること' do
      controller.me?.should be_false
    end

    specify 'トップページへリダイレクトされること' do
      response.should redirect_to(root_url)
    end
  end
end
