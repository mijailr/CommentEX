defmodule Comment.Repository do
  @moduledoc """
  This handle the repositories information to be used
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Comment.{Installation, Repository}

  schema "repositories" do
    field(:full_name, :string)
    field(:name, :integer)
    field(:private, :boolean, default: true)
    field(:repository_id, :string)

    belongs_to(:installation, Installation)

    timestamps()
  end

  def changeset(params) do
    %Repository{}
    |> cast(params, [:full_name, :name, :private, :repository_id])
    |> validate_required([:full_name, :name, :repository_id, :installation_id])
  end
end
