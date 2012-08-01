# coding: utf-8
require 'spec_helper'

describe UsersController do
  let(:user) { User.create!(name: 'akiinyo') }

  describe 'me' do
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
