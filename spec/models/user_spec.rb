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

    describe "password" do
      let(:model) do
        User.new
      end

      it "should be more than 3 characters." do
        model.valid?
        expect(model.errors.key?(:password)).to eq true
        model.password = "aa"
        model.valid?
        expect(model.errors.key?(:password)).to eq true
        model.password = "aaa"
        model.valid?
        expect(model.errors.key?(:password)).to eq false
      end
    end

    describe "password_confirmation" do
      let(:model) do
        User.new
      end

      it "should be presence." do
        model.password = "aaa"
        model.valid?
        expect(model.errors.key?(:password_confirmation)).to eq true
        model.password_confirmation = "aaa"
        model.valid?
        expect(model.errors.key?(:password_confirmation)).to eq false
      end
    end
  end
end
