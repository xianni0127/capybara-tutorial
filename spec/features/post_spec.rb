require 'rails_helper'

RSpec.feature 'post feature', type: :feature do
  scenario 'create new post' do
   visit '/posts'
   click_link('New Post')
   fill_in('post_title', with: 'my first post')
   fill_in('post_content', with: 'I wanna be the full-stack dev')
   click_button('Create Post')
   expect(page.find('[id=notice]')).to  have_content('Post was successfully created')
   click_link('Back')
   expect(page.find('.parent').find('.right').find('li:nth-child(1)')).to have_content('my first post')
  end
end
