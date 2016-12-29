json.extract! experiment, :id, :title, :details, :expected_start_date, :tenant_id, :created_at, :updated_at
json.url experiment_url(experiment, format: :json)