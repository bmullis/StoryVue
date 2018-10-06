defmodule Storyvue.Repo.Migrations.AddCharacterTagsTable do
  use Ecto.Migration

  def change do
    create table(:char_tags) do
      add :char_id, :int
      add :tag_title, :string
      add :tag_color, :string

      timestamps()
    end
  end
end
