class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "netz", password: "w3rk3n"
end
