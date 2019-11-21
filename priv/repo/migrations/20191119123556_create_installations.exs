defmodule Comment.Repo.Migrations.CreateInstallations do
  use Ecto.Migration

  def change do
    create table("installations") do
      add(:installation_id, :integer)
      add(:account_id, :integer)
      add(:account_login, :string)
      add(:account_type, :string)
      add(:active, :boolean, default: true)

      timestamps()
    end

    create(unique_index(:installations, [:installation_id]))
  end
end
