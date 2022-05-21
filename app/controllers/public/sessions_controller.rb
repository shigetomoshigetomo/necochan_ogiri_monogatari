# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to about_before_path, notice: "ゲストログインしました。"
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  #

    #退会済なら新規登録画面へ遷移させる
    def member_state
      @member = Member.find_by(email: params[:member][:email])
      if @member
        if @member.valid_password?(params[:member][:password]) && @member.is_deleted
          flash[:alert] = 'お客様のアカウントは現在ご使用できません。'
          redirect_to new_member_registration_path
        end
      end
    end

    def after_sign_in_path_for(resource)
      boards_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
end