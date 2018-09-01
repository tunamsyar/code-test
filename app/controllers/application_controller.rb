class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Concerns::ErrorHandler
end
