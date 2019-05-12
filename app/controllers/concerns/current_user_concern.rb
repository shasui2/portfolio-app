module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || guest_user
  end

  private
  
  def guest_user
    OpenStruct.new(name: "Guest User",
                   first_name: "random citizen",
                   last_name: "User",
                   email: "placeholder@email.com")
  end
end