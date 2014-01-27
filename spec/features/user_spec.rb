require 'spec_helper'

feature 'User browsing the website' do
  context "on homepage" do
    let!(:post) {create(:post) }
    let!(:post2) {create(:post) }
    let!(:post3) {create(:post) }
    it "sees a list of recent posts titles" do
      visit root_url
      content = Post.recent.map { |post| post.title }
      expect(page).to have_content content.join(' ')
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit root_url
      click_link post.title
      expect(page.current_url).to eq post_url(post)
    end
  end

  context "post show page" do
    let(:post) {create(:post)}
    it "sees title and body of the post" do
      visit post_url(post)
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
end
