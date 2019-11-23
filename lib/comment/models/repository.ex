defmodule Comment.Repository do
  @moduledoc """
  This handle the repositories information to be used
  """
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Comment.{Installation, Repository, Repo}

  schema "repositories" do
    field(:full_name, :string)
    field(:name, :string)
    field(:private, :boolean, default: true)
    field(:repository, :integer)

    belongs_to(:installation, Installation)

    timestamps()
  end

  def create(params) do
    changeset(params)
    |> Repo.insert()
  end

  def count do
    from(r in "repositories", select: count(r.id))
    |> Repo.one()
  end

  def get(id) do
    Repository
    |> Repo.get_by(repository: id)
    |> case do
      {:ok, repository} ->
        repository

      _ ->
        nil
    end
  end

  def destroy!(id) do
    get(id)
    |> case do
      %Repository{} = repo ->
        repo
        |> Repo.delete!()

      _ ->
        nil
    end
  end

  def process(repository) do
    %{
      full_name: repository["full_name"],
      name: repository["name"],
      private: repository["private"],
      repository: repository["id"]
    }
  end

  def changeset(params) do
    %Repository{}
    |> cast(params, [:full_name, :name, :private, :repository, :installation_id])
    |> assoc_constraint(:installation)
    |> validate_required([:full_name, :name, :repository, :installation_id])
    |> unique_constraint(:repository, name: :repositories_repository_index)
  end
end
