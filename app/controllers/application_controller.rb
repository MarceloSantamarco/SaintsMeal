class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate_user!, except: [:create_amounts, :find_amounts, :delete_amount]
end
