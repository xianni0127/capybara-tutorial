require 'rails_helper'

RSpec.feature 'post feature', type: :feature do

  scenario 'create/edit/display/destroy new post' do
    visit '/posts'
    on_page_with :post_list do |page|
    expect(page.posts_in_list.length).to eq(0)
    page.new_post_link.click
    page.perform :fill_post, 'my first post', 'I wanna be the full-stack dev'
    page.create_post_button.click
    expect(page.notice_message).to eq('Post was successfully created.')
    page.back_link.click
    expect(page.posts_in_list.length).to eq(1)
    page.perform :verify_post_data, {:line=>1, :title=>'my first post', :content=>'I wanna be the full-stack dev'}

    page.perform :edit_link_click, {:line=>1}
    page.perform :fill_post, 'my second post', 'I wanna be the front edage dev'
    page.update_post_button.click
    page.back_link.click
    expect(page.posts_in_list.length).to eq(1)
    page.perform :verify_post_data, {:line=>1, :title=>'my second post', :content=>'I wanna be the front edage dev'}

    page.perform :show_link_click, {:line=>1}
    page.perform :verify_show_data, {:title=>'my second post', :content=>'I wanna be the front edage dev'}
    page.back_link.click
    expect(page.posts_in_list.length).to eq(1)

    page.perform :destroy_link_click, {:line=>1}
    page.cancel_destroy
    expect(page.posts_in_list.length).to eq(1)
    page.perform :destroy_link_click, {:line=>1}
    page.accept_destroy
    expect(page.posts_in_list.length).to eq(0)
  end
  end

end
