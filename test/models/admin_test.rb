require "test_helper"

class AdminTest < ActiveSupport::TestCase
  test "should not save admin without email" do
    admin = Admin.new(name: "Test Admin", password: "password", role: "superadmin")
    assert_not admin.save, "Saved the admin without an email"
  end

  test "should save admin with valid attributes" do
    admin = Admin.new(name: "Test Admin", email: "admin@example.com", password: "password", role: "superadmin")
    assert admin.save, "Failed to save admin with valid attributes"
  end
end
