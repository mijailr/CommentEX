import Mix.Config

config :comment, Comment.Repo,
  database: "comment_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
