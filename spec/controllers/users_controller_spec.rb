require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET #new" do
    context do
      before do
        get :new
      end

      it "assings an User object to @user." do
        expect(assigns(:user)).to be_instance_of User
      end
    end

    context do
      subject { get :new }
      it "returns http status 200." do
        expect(subject).to have_http_status(200)
      end

      it "renders new template." do
        expect(subject).to render_template(:new)
      end
    end
  end

  describe "POST #create" do
    let(:user_params) do
      {
        user: {
          email: 'test@test.com',
          password: 'testtest',
          password_confirmation: 'testtest'
        }
      }
    end

    context do
      it "assigns User object to :user." do
        post :create, params: user_params
        expect(assigns(:user)).to be_instance_of User
      end

      it "creates new User record." do
        expect {
          post :create, params: user_params
        }.to change {
          User.count
        }.from(0).to(1)
      end
    end

    context "on success to create an User record," do
      subject {
        post :create, params: user_params
      }

      it "returns http status 302." do
        expect(subject).to have_http_status(302)
      end

      it "redirets to welcome_path." do
        expect(subject).to redirect_to(welcome_path)
      end
    end

    context "on fail to create an User record," do
      subject {
        post :create, params: { user: { email: '', password: '', password_confirmation: '' } }
      }

      it "returns http status 200." do
        expect(subject).to have_http_status(200)
      end

      it "renders new template." do
        expect(subject).to render_template(:new)
      end
    end
  end
end
