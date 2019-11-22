defmodule Comment.Repository do
  @moduledoc """
  This handle the repositories information to be used
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Comment.{Installation, Repository, Repo}

  schema "repositories" do
    field(:full_name, :string)
    field(:name, :string)
    field(:private, :boolean, default: true)
    field(:repository_id, :integer)

    belongs_to(:installation, Installation)

    timestamps()
  end

  def create(params) do
    changeset(params)
    |> Repo.insert()
  end

  def changeset(params) do
    %Repository{}
    |> cast(params, [:full_name, :name, :private, :repository_id, :installation_id])
    |> assoc_constraint(:installation)
    |> validate_required([:full_name, :name, :repository_id, :installation_id])
  end
end
