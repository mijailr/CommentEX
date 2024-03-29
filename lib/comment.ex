defmodule Comment do
  @moduledoc """
  This module handle the application logic
  and start the supervisor with associated
  childrens
  """
  use Application
  alias Comment.{Github, Repo, Server}

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Server,
        options: [port: Application.fetch_env!(:comment, :port)]
      ),
      supervisor(Repo, []),
      supervisor(Github.HandleInstallations, []),
      supervisor(Github.HandleRepositories, [])
    ]

    options = [
      strategy: :one_for_one,
      name: Comment.Supervisor
    ]

    Supervisor.start_link(children, options)
  end
end
