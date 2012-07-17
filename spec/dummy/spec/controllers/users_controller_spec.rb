# coding: utf-8
require 'spec_helper'

describe UsersController do
  let(:user) { User.create!(name: 'akiinyo') }

  describe 'me' do
    before {
      post :create, user: {id: user.id, name: user.name}
    }

    specify 'meが正しく設定されていること' do
      controller.me.name.should == 'akiinyo'
    end
  end
end
