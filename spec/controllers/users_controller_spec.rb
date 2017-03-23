require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_params) {{ username: "Josh Teng", email: "josh@na.com", password: "123456", password_confirmation: "123456"}}
  let(:invalid_params) {{ username: "Josh Teng", email: "joshna.com", password: "123456", password_confirmation: "123456"}}
  let(:valid_params_update) {{ username: "Josh", email: "josh@nextacademy1.com", password: "123456", password_confirmation: "123456"}}
  let(:invalid_params_update) {{ username: "Josh", email: "joshnextacademy1.com", password: "123456", password_confirmation: "123456"}}

  let(:user){User.create(valid_params)}
  let(:user1){User.create(username: "Audrey", email:"audrey@na.com", password: "123456", password_confirmation: "123456")}

  describe "GET #new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns instance user" do
      expect(assigns[:user]).to be_a User
    end
  end


  describe "POST #create" do
    # happy_path
    context "valid_params" do
      it "creates new user if params are correct" do
        expect {post :create, :user => valid_params}.to change(User, :count).by(1)
      end

      it 'redirects to user path and displays flash notice after user created successfully' do
        post :create, user: valid_params
        expect(response).to redirect_to(User.last)
        expect(flash[:success]).to eq "Welcome to the ShoeLace!"
      end
    end
  
# unhappy_path
    context "invalid_params" do
      before do
        post :create, user: invalid_params
      end

      it "displays flash alert message" do
        expect(flash[:danger]).to include "Error creating account"
      end

      it "renders new template again" do
        expect(response).to render_template("new")
      end
    end
  end





end