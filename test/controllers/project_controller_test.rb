require 'test_helper'

class ProjectControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_new_url
    assert_response :success
  end

end
