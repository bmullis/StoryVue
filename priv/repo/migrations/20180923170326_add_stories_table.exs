defmodule Storyvue.Repo.Migrations.AddStoriesTable do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :description, :string
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:stories, [:title])
  end
end
