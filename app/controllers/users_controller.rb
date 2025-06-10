class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, except: :create

  def create
    service = Users::Create.call(user_params)

    render_service_api(:created, nil, service)
  end

  def edit 
    service = Users::Edit.call(user_params[:id])

    render_service_api(:ok, nil, service)
  end

  def update
    service = Users::Update.call(user_params[:id],user_params)

    render_service_api(:ok, nil, service)
  end

  def destroy
    user = User.find user_params[:id]
    
    if user.destroy
      render json: {}, status: :no_content
    else
      render json: { error_messages: user.errors.full_messages }, status: :internal_server_error
    end
  end
  
  private 

  def user_params
    permit_list = [:id, :full_name, :email, :phone, :user_type, :password, :password_confirmation]

    params.permit(permit_list)
  end
end
