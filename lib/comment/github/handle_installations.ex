defmodule Comment.Github.HandleInstallations do
  @moduledoc """
  This module uses GenServer for handle github installations requests
  """
  use GenServer
  alias Comment.{Installation, Repository}

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:create, data}, _) do
    params = %{
      installation: data["installation"]["id"],
      account_login: data["installation"]["account"]["login"],
      account_id: data["installation"]["target_id"],
      account_type: data["installation"]["target_type"]
    }

    repositories =
      data["repositories"]
      |> Enum.map(&Repository.process/1)

    Installation.create(params, repositories)
    |> case do
      %Installation{} = installation ->
        {:noreply, installation}

      _ ->
        {:noreply, "error"}
    end
  end

  def handle_cast({:delete, id}, _) do
    id
    |> Installation.destroy!()

    {:noreply, :ok}
  end

  def execute("created", data) do
    GenServer.cast(__MODULE__, {:create, data})
  end

  def execute("deleted", %{"installation" => %{"id" => id}}) do
    GenServer.cast(__MODULE__, {:delete, id})
  end
end
