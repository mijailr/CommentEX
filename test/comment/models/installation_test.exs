defmodule Comment.Models.InstallationTest do
  use Comment.RepoCase
  alias Comment.Installation
  import Comment.Factory

  @invalid_attributes %{installation_id: "NaN", account_id: "not a number"}
  @valid_attributes %{
    installation_id: 984,
    account_login: "random_user",
    account_id: 6535,
    account_type: "User"
  }

  test "a valid installation" do
    assert {:ok, %Installation{}} = Installation.create(@valid_attributes)
  end

  test "an invalid installation" do
    assert {:error, %Ecto.Changeset{}} = Installation.create(@invalid_attributes)
  end
end
