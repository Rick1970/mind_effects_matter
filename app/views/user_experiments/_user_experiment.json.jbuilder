json.extract! user_experiment, :id, :experiment, :created_at, :updated_at
json.url user_experiment_url(user_experiment, format: :json)