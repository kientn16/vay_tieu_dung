require 'rails_helper'

RSpec.describe User, type: :model do
  describe "db schema" do
    context "columns" do
      it { should have_db_column(:email).of_type(:string) }
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:active_code).of_type(:string) }
      it { should have_db_column(:status).of_type(:integer) }
      it { should have_db_column(:count_login_fail).of_type(:integer) }
      it { should have_db_column(:birthday).of_type(:string) }
      it { should have_db_column(:by_social).of_type(:integer) }
      it { should have_db_column(:facebook_id).of_type(:string) }
      it { should have_db_column(:google_id).of_type(:string) }
      it { should have_db_column(:change_email).of_type(:integer) }
    end
  end
end
