defmodule Comment.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add(:repository_id, :integer)
      add(:name, :string)
      add(:full_name, :string)
      add(:private, :boolean, default: false)
      add(:installation_id, :integer)

      timestamps()
    end
  end
end
