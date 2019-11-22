defmodule Comment.Installation do
  @moduledoc """
  The schema of a app installation, store the information necesary for
  use the app.
  """
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Comment.{Installation, Repo, Repository}

  schema "installations" do
    field(:installation_id, :integer)
    field(:account_login, :string)
    field(:account_id, :integer)
    field(:account_type, :string)
    field(:active, :boolean, default: true)

    has_many(:repositories, Repository, on_delete: :delete_all)

    timestamps()
  end

  def create(params, repositories) do
    %Installation{}
    |> changeset(params, repositories)
    |> Repo.insert()
  end

  def destroy!(installation_id) do
    Installation
    |> Repo.get_by!(installation_id: installation_id)
    |> Repo.delete!()
  end

  def count do
    from(r in "installations", select: count(r.id))
    |> Repo.one()
  end

  def changeset(%Installation{} = schema, params, repositories) do
    schema
    |> cast(params, [:account_id, :account_login, :account_type, :installation_id])
    |> put_assoc(:repositories, repositories)
    |> cast_assoc(:repositories, with: &Repository.changeset/1)
    |> validate_required([:account_id, :account_login, :account_type, :installation_id])
    |> unique_constraint(:installation_id)
  end
end
