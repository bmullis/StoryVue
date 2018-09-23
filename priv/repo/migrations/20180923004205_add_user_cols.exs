defmodule Storyvue.Repo.Migrations.AddUserCols do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :crypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
