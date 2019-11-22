defmodule Comment.Models.InstallationTest do
  use Comment.RepoCase
  import Comment.Factory
  alias Comment.{Installation, Repository}
  import Ecto.Query

  test "a valid installation" do
    assert {:ok, %Installation{}} =
             params_for(:installation)
             |> Installation.create([])
  end

  test "an invalid installation" do
    assert {:error, %Ecto.Changeset{}} =
             params_for(:installation, installation_id: nil)
             |> Installation.create([])
  end

  test "destroy a installation" do
    installation = insert(:installation)
    insert_list(5, :repository, installation_id: installation.id)
    count = Installation.count()
    repo_count = Repository.count()

    Installation.destroy!(installation.installation_id)
    assert Installation.count() == count - 1
    assert Repository.count() == repo_count - 5
  end
end
