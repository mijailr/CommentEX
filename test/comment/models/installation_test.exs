defmodule Comment.Models.InstallationTest do
  use Comment.RepoCase
  import Comment.Factory
  alias Comment.Installation

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
end
