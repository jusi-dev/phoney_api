import Config

config :phoney_api, PhoneyApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "phoney_api_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
