require 'rails_helper'

RSpec.describe Shoe, type: :model do



	context "validations" do
    it "should have name and content and user_id" do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:brand).of_type(:string)
      should have_db_column(:price).of_type(:float)
    end

     describe "validates presence of attributes" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:brand) }
      it { is_expected.to validate_presence_of(:price) }
    end

    describe "validates length of title & content" do
      it { should validate_length_of(:description).is_at_least(10).with_message(/description is too short/)}
    end
end
	  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:shoe_categories) }
    it { is_expected.to have_many(:purchases) }
    it { is_expected.to have_many(:categories).through(:shoe_categories) }
    it { is_expected.to have_many(:buyers).through(:purchases) }

  end

end