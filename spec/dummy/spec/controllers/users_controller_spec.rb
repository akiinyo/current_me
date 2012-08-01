# coding: utf-8
require 'spec_helper'

describe UsersController do
  describe 'sign up' do
    before {post :create, user: {name: 'akiinyo'} }

    specify 'sign-upできること' do
      controller.me.name.should == 'akiinyo'
    end
  end

  describe 'me' do
    let(:user) { User.create!(name: 'akiinyo') }

    describe 'side jacking protection' do
      before do
        controller.sign_in user
        request.stub!(:ssl?).and_return true
      end

      context 'valid secure_me' do
        before { get :show, {id: user.id} }

          specify 'ログインしているユーザが引けること' do
            response.should be_success
          end
      end

      context 'invalid secure_me' do
        before do
          cookies.signed[:secure_me] = {value: 'fake'}
          get :show, {id: user.id}
        end

        specify 'ユーザが引けずにアクセス拒否されること' do
          response.should be_forbidden
        end
      end
    end
  end
end
