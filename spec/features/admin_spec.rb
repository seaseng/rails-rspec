require 'spec_helper'

feature 'Admin panel' do
  context "on admin homepage" do
    let!(:post) {create(:post) }
    let!(:post2) {create(:post) }
    let!(:post3) {create(:post) }
    it "can see a list of recent posts" do
      visit admin_posts_url
      Post.recent.each do |post|
        expect(page).to have_content post.title
      end
    end


    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_url
      page.first(:link, 'Edit').click
      expect(page.current_url).to eq edit_admin_post_url(post)
    end

    it "can delete a post by clicking the delete link next to a post" do
      expect {
        visit admin_posts_url
        page.first(:link, 'Delete').click     
      }.to change(Post, :count).by(-1)
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

       fill_in 'post_title',   with: "Hello world!"
       fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
       page.check('post_is_published')
       expect {
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    let(:post) {create(:post)}
    it "can mark an existing post as unpublished" do
      visit edit_admin_post_url(post)
      page.find('#post_is_published').set false
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    let!(:post) {create(:post)}
    it "can visit a post show page by clicking the title" do
      visit admin_posts_url
      click_on post.title
      expect(page.current_url).to eq admin_post_url(post)
    end

    it "can see an edit link that takes you to the edit post path" do 
      visit admin_posts_url
      click_on 'Edit'
      expect(page.current_url).to eq edit_admin_post_url(post)
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do 
      visit admin_post_url(post)
      click_on "Admin welcome page"
      expect(page.current_url).to eq admin_posts_url
    end
  end
end
