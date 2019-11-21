defmodule Comment.Repo do
  use Ecto.Repo,
    otp_app: :comment,
    adapter: Ecto.Adapters.Postgres
end
