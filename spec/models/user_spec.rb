require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    describe "email" do
      before do
        FactoryGirl::create(:user)
      end

      it "should be unique." do
        user = User.new(email: 'test@test.com')
        user.valid?
        expect(user.errors.key?(:email)).to eq true

        user.email = 'test2@test.com'
        user.valid?
        expect(user.errors.key?(:email)).to eq false
      end
    end
  end
end
