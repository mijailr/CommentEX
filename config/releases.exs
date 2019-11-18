import Config

config :comment,
  github: [
    rsa_key: System.fetch_env!("RSA_PRIVATE_KEY"),
    app_id: System.fetch_env!("GITHUB_APP_ID")
  ]

config :tentacat,
  deserialization_options: [],
  extra_headers: [],
  pagination: [],
  request_options: []
