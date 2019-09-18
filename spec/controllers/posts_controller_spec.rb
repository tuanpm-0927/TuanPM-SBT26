require "rails_helper"
require "helpers/spec_test_helper"

RSpec.describe PostsController, type: :controller do
  include SpecTestHelper

  let(:user){FactoryBot.create :user}
  let(:category){FactoryBot.create :category}
  let(:post){FactoryBot.create :post}
  let(:invalid_params){{title: "", content: ""}}
  describe "before action" do
    it {is_expected.to use_before_action :load_post}
    it {is_expected.to use_before_action :check_current_user}
    it {is_expected.to use_before_action :check_user_post}
  end

  describe "GET #index" do
    context "when user not login" do
      before {get :index}

      it{expect(response).to redirect_to login_url}
    end

    context "when user login" do
      before do
        log_in user
        get :index
      end
      it{expect(response).to render_template :index}
    end
  end

  describe "GET #new" do
    context "when user not login" do
      before {get :new}

      it{expect(response).to redirect_to login_url}
    end

    context "when user login" do
      before do
        log_in user
        get :new
      end
      it{expect(response).to render_template :new}
    end
  end
  
  describe "GET #edit" do
    context "when user not login" do
      before{get :edit, params:{id: post.id}}
      it{expect(response).to redirect_to login_path}
    end

    context "when user login" do
      before do
        log_in user
        get :edit, params: {id: post.id}
      end

      it{expect(response).to render_template :edit}
    end
  end

  describe "POST #create" do
    before {log_in user}

    context "when valid attributes" do
      it do
        post :create, params: {post: FactoryBot.attributes_for(:post)}
        it{expect(response).to redirect_to posts_path}
      end
    end

    context "when invalid atrributes" do
      it do
        post :create, params: {post: invalid_params}
        it{expect(response).to render_template :new}
      end
    end
  end

  describe "PUT update" do
    before {log_in user}

    context "valid attributes" do
      it do
        put :update, params: {post: FactoryBot.attributes_for(:post), id: post.id}
        expect(assigns(:post)).to be_a Post
      end
    end

    context "invalid attributes" do
      it do
        put :update, params: {post: invalid_params, id: post.id}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before{log_in user}

    context "when user delete success" do
      it do
        delete :destroy, params: {id: post.id}
        expect(response).to redirect_to posts_path
      end
    end
  end
end
