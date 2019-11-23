defmodule Comment.Repo.Migrations.CreateInstallations do
  use Ecto.Migration

  def change do
    create table(:installations) do
      add(:installation, :integer, null: false)
      add(:account_id, :integer, null: false)
      add(:account_login, :string, null: false)
      add(:account_type, :string, null: false)
      add(:active, :boolean, default: true)

      timestamps()
    end

    create(unique_index(:installations, [:installation]))
  end
end
