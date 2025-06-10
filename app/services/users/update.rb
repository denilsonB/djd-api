class Users::Create
  prepend SimpleCommand

  def initialize(user_id,params)
    @user = User.find(user_id)
    @params = params
  end

  def call
    return errors.add(:user_not_exists, 'User not exists') unless @user

    return user.as_json if user.update(@params)
    
    errors.add(:error_in_create_users, user.errors.full_messages)
  rescue => e
    p "Error Create User"
    p e.to_s
    errors.add(:error_in_create_users, user.errors.full_messages)
  end
end
