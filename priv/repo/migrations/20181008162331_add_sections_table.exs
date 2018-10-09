defmodule Storyvue.Repo.Migrations.AddSectionsTable do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :title, :string
      add :description, :string
      add :order, :int
      add :story_id, :int

      timestamps()
    end
  end
end
