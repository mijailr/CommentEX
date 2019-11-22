defmodule Comment.Github do
  @moduledoc """
  This module handle the Github actions for installations
  and pull requests.
  """

  alias Comment.{Installation, Repository}

  def handle_request("installation" = event, %{
        "action" => action,
        "installation" => installation,
        "repositories" => repositories
      }) do
    event
    |> handle_action(action, installation, repositories)
  end

  def handle_request(_event, params) do
    IO.puts(params)
  end

  defp handle_action("installation", "created", details, repos) do
    params = %{
      installation_id: details["id"],
      account_login: details["account"]["login"],
      account_id: details["target_id"],
      account_type: details["target_type"]
    }

    repositories =
      repos
      |> Enum.map(&convert_repositories/1)

    Installation.create(params, repositories)
  end

  defp convert_repositories(repo) do
    Repository.changeset(%{
      full_name: repo["full_name"],
      name: repo["name"],
      private: repo["private"],
      repository_id: repo["id"]
    })
  end
end
