class UserResource
  include Alba::Resource

  root_key :user

  attributes :id, :email
end
