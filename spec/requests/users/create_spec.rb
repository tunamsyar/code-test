require 'rails_helper'

describe UsersController, type: :request do
  let!(:assets) { create_list(:asset, 5) }
  it '' do
    post '/users',
         params:
          {
            user:
              {
                name: 'testname',
                email: 'test@amil.com',
                password_digest: 'password',
                country: 'my'
              }
          }
  end
end
