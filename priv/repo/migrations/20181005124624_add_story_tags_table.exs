defmodule Storyvue.Repo.Migrations.AddStoryTagsTable do
  use Ecto.Migration

  def change do
    create table(:story_tags) do
      add :story_id, :int
      add :tag_title, :string
      add :tag_color, :string

      timestamps()
    end
  end
end
