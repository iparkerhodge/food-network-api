class ApiKeyResource
  include Alba::Resource

  root_key :api_key

  attributes :id
  attribute :created_at do |api_key|
    api_key.created_at.to_date
  end
  attribute :deleted_at do |api_key|
    api_key&.deleted_at&.to_date
  end
end
