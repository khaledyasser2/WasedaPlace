require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title="WasedaPlace"
  end
  
  test "all the links work" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"

    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"

    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"

    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end
