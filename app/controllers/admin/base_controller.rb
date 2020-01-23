class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate


  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'admin' && password == 'password'
    end
  end
end
