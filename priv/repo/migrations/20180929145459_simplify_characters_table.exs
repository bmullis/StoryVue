defmodule Storyvue.Repo.Migrations.SimplifyCharactersTable do
  use Ecto.Migration

  def change do
    alter table("characters") do
      remove :char_goals
      remove :related_chars
    end
  end
end
