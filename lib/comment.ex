defmodule Comment do
  @moduledoc """
  This module handle the application logic
  and start the supervisor with associated
  childrens
  """
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Comment.Server,
        options: [port: 3000]
      )
    ]

    options = [
      strategy: :one_for_one,
      name: Comment.Supervisor
    ]

    Supervisor.start_link(children, options)
  end
end
