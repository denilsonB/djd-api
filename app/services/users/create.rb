class Users::Create
  prepend SimpleCommand

  def initialize(params)
    @params = params
  end

  def call
    user = User.new(@params)

    return user.as_json if user.save
    
    errors.add(:error_in_create_users, user.errors.full_messages)
  rescue => e
    p "Error Create User"
    p e.to_s
    errors.add(:error_in_create_users, user.errors.full_messages)
  end
end
