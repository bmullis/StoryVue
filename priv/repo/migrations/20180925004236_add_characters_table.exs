defmodule Storyvue.Repo.Migrations.AddCharactersTable do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :char_name, :string
      add :char_image, :string
      add :char_date_of_birth, :date
      add :char_place_of_birth, :string
      add :char_education, :string
      add :char_occupation, :string
      add :char_description, :string
      add :char_desire, :string
      add :char_goals, {:array, :string}
      add :related_chars, {:array, :int}
      add :story_id, references(:stories)

      timestamps()
    end

    create unique_index(:characters, [:id])
  end
end
