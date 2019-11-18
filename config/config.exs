import Config

# config :comment,
#   github: [
#     {:secret_key, System.fetch_env!("GITHUB_SECRET_KEY")},
#     {:app_id, System.fetch_env!("GITHUB_APP_ID")},
#     {:rsa_key, System.fetch_env!("RSA_PRIVATE_KEY")}
#   ]

config :tentacat,
  deserialization_options: [],
  extra_headers: [],
  pagination: [],
  request_options: []
