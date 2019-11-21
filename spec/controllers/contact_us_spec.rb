require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe ContactUsController, type: :controller do
  describe 'GET #index' do
    # render_views -- To also include render html alongwith response
    before { get :index }
    it { expect(response).to have_http_status(:success) }
    it { should render_template('index') }
    it { should respond_with 200 }
    it { should_not use_before_action :authenticate_user! }
    it { should render_with_layout('application') }
  end
end
