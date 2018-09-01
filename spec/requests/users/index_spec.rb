require 'rails_helper'

describe 'UsersController', type: :request do
  let!(:users) { create_list(:user, 5) }
  let!(:user) { create(:user) }

  it '' do
    get '/users', headers: authenticated_header(user)
  end
end
