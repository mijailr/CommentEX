defmodule Comment.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add(:repository_id, :integer, null: false)
      add(:name, :string, null: false)
      add(:full_name, :string, null: false)
      add(:private, :boolean, default: false)
      add(:installation_id, references(:installations), null: false)

      timestamps()
    end

    create(unique_index(:repositories, [:installation_id]))
  end
end
