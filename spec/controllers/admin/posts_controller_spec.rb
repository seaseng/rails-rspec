require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      expect(response.status).to eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
        post :create, post: {title: 'title', content: 'content'}
        }.to change(Post, :count).by(1)
        expect(respone.url).to redirect_to post_url(Post.last) 
      end
      it "doesn't create a post when params are invalid" do
        pending
      end
    end

    context "#edit" do
      it "updates a post with valid params" do
        pending
      end
      it "doesn't update a post when params are invalid" do
        pending
      end
    end

    it "#destroy" do
      pending
    end
  end
end
