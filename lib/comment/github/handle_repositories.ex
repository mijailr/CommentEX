defmodule Comment.Github.HandleRepositories do
  @moduledoc """
  This module uses GenServer for handle github repositories requests
  """
  use GenServer
  alias Comment.{Installation, Repository}

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:add, data}, _) do
    repositories =
      data["repositories_added"]
      |> Enum.map(&Repository.process/1)

    data["installation"]["id"]
    |> Installation.get!()
    |> Installation.add_repositories!(repositories)
    |> case do
      %Installation{} = installation ->
        {:noreply, installation}

      _ ->
        {:noreply, "error"}
    end
  end

  def handle_cast({:remove, data}, _) do
    data["repositories_removed"]
    |> Enum.map(&Map.fetch!(&1, "id"))
    |> Enum.each(&Repository.destroy!/1)

    {:noreply, :ok}
  end

  def execute("added", data) do
    GenServer.cast(__MODULE__, {:add, data})
  end

  def execute("removed", data) do
    GenServer.cast(__MODULE__, {:remove, data})
  end
end
