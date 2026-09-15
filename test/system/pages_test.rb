require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_path
    assert_selector "body"
  end

  test "visiting the services page" do
    visit services_path
    assert_text "brake or gear adjustment"
  end

  test "visiting the visit page" do
    visit visit_path
    assert_selector "body"
  end

  test "visiting the about page" do
    visit about_path
    assert_selector "body"
  end
end
