require 'spec_helper'
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  it { is_expected.to have_field(:phone) }
  it { is_expected.to have_field(:email) }
  it { is_expected.to have_field(:first_name) }
  it { is_expected.to have_field(:last_name) }
  it { is_expected.to have_field(:username) }
  it { is_expected.to have_field(:followers) }
  it { is_expected.to have_field(:following) }
  it { should have_db_column(:first_name) }
  it { should have_db_column(:last_name) }
  it { should have_db_column(:username) }
  it { should have_db_column(:followers) }
  it { should have_db_column(:following) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { should serialize(:followers) }
  it { should serialize(:following) }
end
