require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe "GET #index" do
    context "When the user is logged in," do
      before do
        @user = FactoryGirl::create(:user, email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
        login_user
      end

      subject {
        get :index
      }

      it "returns http status 200." do
        expect(subject).to have_http_status(200)
      end

      it "renders the index template." do
        expect(subject).to render_template(:index)
      end
    end

    context "When the user is not logged in," do
      subject {
        get :index
      }

      it "returns http status 302." do
        expect(subject).to have_http_status(302)
      end

      it "redirects to welcome_path." do
        expect(subject).to redirect_to(welcome_path)
      end
    end
  end
end
