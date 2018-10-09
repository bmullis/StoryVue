defmodule Storyvue.Repo.Migrations.AddNotesTable do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :content, :text
      add :order, :int
      add :story_id, :int

      timestamps()
    end
  end
end
