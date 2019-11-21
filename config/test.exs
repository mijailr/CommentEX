import Config

config :comment, Comment.Repo,
  database: "comment_test",
  hostname: System.get_env("DATABASE_HOSTNAME", "localhost"),
  username: System.get_env("DATABASE_USERNAME", "postgres"),
  password: System.get_env("DATABASE_PASSWORD", ""),
  pool: Ecto.Adapters.SQL.Sandbox
