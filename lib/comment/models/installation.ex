defmodule Comment.Installation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comment.{Installation, Repo, Repository}

  schema "installations" do
    field(:installation_id, :integer)
    field(:account_login, :string)
    field(:account_id, :integer)
    field(:account_type, :string)
    field(:active, :boolean, default: true)

    has_many(:repositories, Repository)

    timestamps()
  end

  def create(params) do
    %Installation{}
    |> changeset(params)
    |> Repo.insert()
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:account_id, :account_login, :account_type, :installation_id])
    |> validate_required([:account_id, :account_login, :account_type, :installation_id])
    |> unique_constraint(:installation_id)
  end
end
