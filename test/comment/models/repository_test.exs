defmodule Comment.Models.RepositoryTest do
  use Comment.RepoCase
  import Comment.Factory
  alias Comment.Repository

  test "a valid installation with repositories" do
    installation = insert(:installation)

    repo = params_for(:repository, installation_id: installation.id)

    {:ok, repository} =
      repo
      |> Repository.create()

    assert %Repository{} = repository
  end

  test "invalid repositories" do
    assert {:error, %Ecto.Changeset{}} =
             params_for(:repository, name: nil)
             |> Repository.create()
  end
end
