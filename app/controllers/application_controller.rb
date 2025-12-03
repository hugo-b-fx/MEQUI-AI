class ApplicationController < ActionController::Base
  before_action :fake_user_for_dev

  def fake_user_for_dev
    return if current_user.present?

    @dev_user ||= User.first || User.create!(
      email: "dev@example.com",
      password: "password123",
      name: "Dev User",
      role: :rider
    )

    sign_in(@dev_user)
  end

end
