defmodule Comment.Github do
  @moduledoc """
  This module handle the Github actions for installations
  and pull requests.
  """

  alias Comment.{Installation}

  def handle_request(
        "installation" = event,
        %{
          "action" => action
        } = data
      ) do
    event
    |> handle_action(action, data)
  end

  def handle_request(_event, _data)

  defp handle_action("installation", "created", data) do
    params = %{
      installation_id: data["installation"]["id"],
      account_login: data["installation"]["account"]["login"],
      account_id: data["installation"]["target_id"],
      account_type: data["installation"]["target_type"]
    }

    repositories =
      data["repositories"]
      |> Enum.map(&convert_repositories/1)

    Installation.create(params, repositories)
  end

  defp handle_action("installation", "deleted", %{"installation" => %{"id" => id}}) do
    id
    |> Installation.destroy!()
  end

  defp convert_repositories(repo) do
    %{
      full_name: repo["full_name"],
      name: repo["name"],
      private: repo["private"],
      repository_id: repo["id"]
    }
  end
end
