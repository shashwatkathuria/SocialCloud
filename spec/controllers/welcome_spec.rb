require 'rails/mongoid'
require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe WelcomeController, type: :controller do
  describe '#index' do
    # render_views
    # render_views -- To also include render html alongwith response
    context 'GET' do
      before { get :index }
      # it { p response.body}
      it { expect(response).to have_http_status(:success) }
      it { should render_template('index') }
      it { should respond_with 200 }
      it { should_not use_before_action :authenticate_user! }
      it { should render_with_layout('application') }
    end
  end
end
