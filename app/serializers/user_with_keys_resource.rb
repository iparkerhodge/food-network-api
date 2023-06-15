class UserWithKeysResource
  include Alba::Resource

  root_key :user

  attributes :id, :email

  many :api_keys, resource: ApiKeyResource
end
