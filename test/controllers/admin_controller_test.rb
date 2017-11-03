require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get articles" do
    get admin_articles_url
    assert_response :success
  end

end
