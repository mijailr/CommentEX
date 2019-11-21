import Config

config :comment,
  github_secret_key: System.fetch_env!("GITHUB_SECRET_KEY"),
  github_app_id: System.fetch_env!("GITHUB_APP_ID")

config :comment, Comment.Repo,
  database: System.fetch_env!("DATABASE_NAME"),
  username: System.fetch_env!("DATABASE_USER"),
  password: System.fetch_env!("DATABASE_PASS"),
  hostname: System.fetch_env!("DATABASE_HOST")

config :joken,
  github: [
    signer_alg: "RS256",
    key_pem: System.fetch_env!("RSA_PRIVATE_KEY") |> String.replace(~r/\\n/, "\n")
  ]

config :tentacat,
  deserialization_options: [],
  extra_headers: [
    {"Accept", "application/vnd.github.machine-man-preview+json"}
  ],
  pagination: [],
  request_options: []
