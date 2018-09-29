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
end
