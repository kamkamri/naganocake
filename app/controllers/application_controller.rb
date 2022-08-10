class ApplicationController < ActionController::Base

  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  # resource_or_scope　引数を使用することにより、リダイレクト先を分岐させる
  # def after_sign_in_path_for(resource_or_scope)
  #   # adminが含まれていたら
  #   if resource_or_scope.is_a?(Admin)
  #     admin_root_path
  #   else
  #     rood_path
  #   end
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   if resource_or_scope == :admin
  #     new_admin_session_path
  #   else
  #     root_path
  #   end
  # end

end
