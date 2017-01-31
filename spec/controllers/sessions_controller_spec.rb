require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views

  describe "new" do
    subject {
      get :new
    }

    it "should respond with 200." do
      expect(subject).to be_success
    end

    it "should render the new.html.erb" do
      expect(subject).to render_template(:new)
    end
  end

  describe "create" do
    context "on authentication success," do
      before do
        FactoryGirl::create(:user, email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
        params = { email: 'test@test.com', password: 'testtest' }
        post :create, params: params
      end

      it "should respond 302." do
        expect(response.status).to eq 302
      end

      it "should assign the User object to @user." do
        expect(assigns(:user)).not_to be_nil
      end

      it "should redirect to root_path." do
        expect(response).to redirect_to(root_path)
      end
    end

    context "on authentication fail," do
      subject {
        params = { email: 'test@test.com', password: 'testtest' }
        post :create, params: params
      }

      it "should respond 302." do
        expect(subject).to be_success
      end

      it "should render new.html.erb." do
        expect(subject).to render_template(:new)
      end
    end
  end

  describe "destroy" do
    context do
      before do
        @user = FactoryGirl::create(:user, email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
        login_user
      end

      context do
        it "should run logout method." do
          allow(@controller).to receive(:logout).once
          delete :destroy
        end
      end

      subject {
        delete :destroy
      }

      it "should respond 302." do
        expect(subject.status).to eq 302
      end

      it "should redirect to welcome_path" do
        expect(subject).to redirect_to welcome_path
      end
    end

    context "when there is no sessions," do
      subject {
        delete :destroy
      }

      it "should respond 302." do
        expect(subject.status).to eq 302
      end

      it "should redirect to welcome_path." do
        expect(subject).to redirect_to welcome_path
      end
    end
  end
end
