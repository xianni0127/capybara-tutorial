module PageWithPostList
	include Gizmo::PageMixin

	def valid?
		has_css?('.parent .left')
	end

  def posts_in_list
		find('.parent .left table').find('tbody').all('tr')
	end

	def new_post_link
		find('.parent .left a[href="/posts/new"]')
	end

	def create_post_button
		find('.actions input[value="Create Post"]')
	end

	def update_post_button
		find('.actions input[value="Update Post"]')
	end

	def notice_message
		find('#notice').text
	end

	def back_link
		find('a[href="/posts"]')
	end

  define_action :edit_link_click do |index|
		find_all('tr')[index[:line]].all('td')[4].click
	end

	define_action :show_link_click do |index|
		find_all('tr')[index[:line]].all('td')[3].click
	end

	define_action :destroy_link_click do |index|
		find_all('tr')[index[:line]].all('td')[5].click
	end

	define_action :fill_post do |title, content|
		fill_in('post_title', with: title)
		fill_in('post_content', with: content)
	end

	define_action :verify_post_title do |index, title|
		expect(find_all('tr')[index[:line]].all('td')[0].text).to eq(title)
	end

	define_action :verify_post_content do |index, content|
		expect(find_all('tr')[index[:line]].all('td')[1].text).to eq(content)

	end

	define_action :verify_post_data do |index|
		expect(find_all('tr')[index[:line]].all('td')[0].text).to eq(index[:title])
		expect(find_all('tr')[index[:line]].all('td')[1].text).to eq(index[:content])
	end

	define_action :verify_show_data do |args|
		expect(has_text?(args[:content])).to eq(true)
		expect(has_text?(args[:title])).to eq(true)

	end

	 def accept_destroy
        page.driver.browser.switch_to.alert.accept
    end

    def cancel_destroy
        page.driver.browser.switch_to.alert.dismiss
    end


end
