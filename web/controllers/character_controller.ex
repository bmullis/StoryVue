defmodule Storyvue.CharacterController do
  use Storyvue.Web, :controller
  alias Storyvue.Character

  def index(conn, %{"story_id" => story_id}) do
    character_query = character_query = from c in Storyvue.Character, where: c.story_id == ^story_id
    characters = Repo.all(character_query)
    story = Repo.get(Storyvue.Story, story_id)
    render conn, "index.html", characters: characters, story_id: story_id, story: story
  end

  def new(conn, %{"story_id" => story_id}) do
    changeset = Character.changeset(%Character{}, %{})
    render conn, "new.html", changeset: changeset, story_id: story_id
  end

  def create(conn, %{"character" => character, "story_id" => story_id}) do
    changeset = Character.changeset(%Character{}, character)

    case Repo.insert(changeset) do
      {:ok, _character} ->
        conn
        |> put_flash(:info, "Your new character was successfully created")
        |> redirect(to: story_path(conn, :show, story_id))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => char_id, "story_id" => story_id}) do
    character = Repo.get(Character, char_id)

    render conn, "show.html", character: character, story_id: story_id
  end

  def edit(conn, %{"id" => character_id, "story_id" => story_id}) do
    character = Repo.get(Character, character_id)
    changeset = Character.changeset(character)

    render conn, "edit.html", changeset: changeset, character: character, story_id: story_id
  end

  def update(conn, %{"id" => char_id, "character" => character, "story_id" => story_id}) do
    old_character = Repo.get(Character, char_id)
    changeset = Character.changeset(old_character, character)

    case Repo.update(changeset) do
      {:ok, _character} ->
        conn
        |> put_flash(:info, "Your character was successfully updated")
        |> redirect(to: story_character_path(conn, :show, story_id, char_id))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, character: old_character
    end
  end

  def delete(conn, %{"id" => char_id, "story_id" => story_id}) do
    Repo.get!(Character, char_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Your character was successfully deleted")
    |> redirect(to: story_character_path(conn, :index, story_id))
  end
end
