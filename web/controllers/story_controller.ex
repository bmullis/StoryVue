defmodule Storyvue.StoryController do
  use Storyvue.Web, :controller
  alias Storyvue.Story
  alias Storyvue.CharTag
  alias Storyvue.StoryTag

  def index(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user)
    story_query = from s in Story,
      where: s.user_id == ^current_user_id,
      preload: [:story_tags]
    stories = Repo.all(story_query)
    render conn, "index.html", stories: stories
  end

  def new(conn, _params) do
    changeset = Story.changeset(%Story{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"story" => story}) do
    changeset = Story.changeset(%Story{}, story)

    case Repo.insert(changeset) do
      {:ok, _story} ->
        conn
        |> put_flash(:info, "Your new story was successfully created")
        |> redirect(to: story_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => story_id}) do
    story = Repo.get(Story, story_id) |> Repo.preload([:sections, [{:characters, :char_tags}]])

    render conn, "show.html", story: story
  end

  def edit(conn, %{"id" => story_id}) do
    story = Repo.get(Story, story_id)
    changeset = Story.changeset(story)

    render conn, "edit.html", changeset: changeset, story: story
  end

  def update(conn, %{"id" => story_id, "story" => story}) do
    old_story = Repo.get(Story, story_id)
    changeset = Story.changeset(old_story, story)

    case Repo.update(changeset) do
      {:ok, _payment} ->
        conn
        |> put_flash(:info, "Your story was successfully updated")
        |> redirect(to: story_path(conn, :show, story_id))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, story: old_story
    end
  end

  def delete(conn, %{"id" => story_id}) do
    character_query = from c in Storyvue.Character, where: c.story_id == ^story_id
    characters = Repo.all(character_query)
      for character <- characters do
        Repo.get!(Storyvue.Character, character.id)
        |> Repo.delete!
      end
    Repo.get!(Story, story_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Your story was successfully deleted")
    |> redirect(to: story_path(conn, :index))
  end
end
