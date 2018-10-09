defmodule Storyvue.Repo.Migrations.AddMomentsTable do
  use Ecto.Migration

  def change do
    create table(:moments) do
      add :title, :string
      add :setting, :string
      add :content, :text
      add :order, :int
      add :section_id, :int

      timestamps()
    end
  end
end
