defmodule Storyvue.Repo.Migrations.AddSchoolCharactersTable do
  use Ecto.Migration

  def change do
    alter table("characters") do
      add :char_school, :string
    end
  end
  
end
