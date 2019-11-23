defmodule Comment.Github do
  @moduledoc """
  This module handle the Github actions for installations
  and pull requests.
  """

  alias Comment.Github.{HandleInstallations, HandleRepositories}

  def handle_request(:installation, %{"action" => action} = data) do
    HandleInstallations.execute(action, data)
  end

  def handle_request(:installation_repositories, %{"action" => action} = data) do
    HandleRepositories.execute(action, data)
  end

  def handle_request(_event, _data), do: "not_implemented"
end
