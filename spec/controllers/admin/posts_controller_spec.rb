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
        expect(response).to redirect_to admin_post_url(Post.last) 
      end
      it "doesn't create a post when params are invalid" do
        expect {
          post :create, post: {title: nil, content: nil}
          }.not_to change(Post, :count)
        expect(response).to render_template :new
      end
    end

    context "#edit" do
      let(:post) { Post.create(title: 'title', content: 'content') }
      it "updates a post with valid params" do
        put :update, id: post.id, post: {title: 'new title', content: 'new content'}
        post.reload
        expect(post.title).to eq 'new title'.titleize
        expect(post.content).to eq 'new content'
      end
      it "doesn't update a post when params are invalid" do
        put :update, id: post.id, post: {title: '', content: 'new content'}
        expect(post.title).not_to eq ''
        expect(post.content).not_to eq 'new content'
      end
    end

    context "Delete destroy" do
      let!(:post) { Post.create(title: 'title', content: 'content') }
      it "deletes a post" do
        expect{
          delete :destroy, id: post
          }.to change(Post, :count).by(-1)

      end
    end

  end
end
