import Config

config :comment,
  github_secret_key: "dummysecretkey",
  github_app_id: "00000"

config :comment, Comment.Repo,
  database: "comment_test",
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", ""),
  pool: Ecto.Adapters.SQL.Sandbox
