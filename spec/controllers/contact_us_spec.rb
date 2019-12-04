require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe ContactUsController, type: :controller do
  describe '#index' do
    # render_views -- To also include render html alongwith response
    context 'GET' do
      before { get :index }

      it 'Checking Response Status Code' do
        expect(response).to have_http_status(:success)
        should respond_with 200
      end
      it 'Checking Rendered Templates and Layouts' do
         should render_template('index')
         should render_with_layout('application')
      end
      it 'Checking If Authentication Step Is Used' do
        should_not use_before_action :authenticate_user!
      end

    end
  end
end
