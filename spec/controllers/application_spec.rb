require 'spec_helper'
require 'mongoid_paperclip'
require 'paperclip/matchers'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe ApplicationController, type: :controller do
  describe 'Main Application Controller Configuration' do
    it { should use_before_action :authenticate_user! }
    it { should use_before_action :configure_permitted_parameters }
  end
end
