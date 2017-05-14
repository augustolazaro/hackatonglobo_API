class Api::UsersController < Api::BaseController

  def set_to_blacklist
    user = User.find_by_name(params[:name])
    if user.present?
      user.update_attributes(rating: 0)
    end
  end

end
