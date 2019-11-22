import Config

config :comment,
  github_secret_key: System.get_env("GITHUB_SECRET_KEY", "dummysecretkey"),
  github_app_id: System.get_env("GITHUB_APP_ID", "00000")

config :comment, Comment.Repo,
  database: "comment_dev",
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", "")
