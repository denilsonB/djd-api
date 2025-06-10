class Users::Edit
  prepend SimpleCommand

  def initialize(params)
    @user = User.where(id: user_id).try(:first)
  end

  def call
    return errors.add(:user_not_exists, 'User not exists') unless @user

    {
      id: @user.id,
      email: @user.email,
      full_name: @user.full_name,
      phone: @user.phone,
    }
  end
end
