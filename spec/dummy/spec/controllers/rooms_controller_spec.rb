# coding: utf-8
require 'spec_helper'

describe RoomsController do
  describe 'me!' do
    let!(:user) { User.create!(name: 'akiinyo') }

    subject &:response

    context 'ログインしている場合' do
      before do
        controller.me = user
        get :index
      end

      it { should render_template('index') }
    end

    context 'ログインしていない場合' do
      before { get :index }

      it { should redirect_to(root_url) }
    end
  end
end
