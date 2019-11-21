defmodule Comment.Models.InstallationTest do
  use Comment.RepoCase
  import Comment.Installation
  alias Comment.Installation

  @invalid_attributes %{installation_id: "NaN", account_id: "not a number"}
  @valid_attributes %{
    installation_id: 984,
    account_login: "random_user",
    account_id: 6535,
    account_type: "User"
  }

  test "a valid installation" do
    assert {:ok, %Installation{}} = create(@valid_attributes)
  end

  test "an invalid installation" do
    assert {:error, %Ecto.Changeset{}} = create(@invalid_attributes)
  end
end
