defmodule Storyvue.CharTagController do
  use Storyvue.Web, :controller
  alias Storyvue.CharTag

  def index(conn, %{"character_id" => char_id, "story_id" => story_id}) do
    tag_query = from t in CharTag, where: t.char_id == ^char_id
    tags = Repo.all(tag_query)
    render conn, "index.html", tags: tags, char_id: char_id, story_id: story_id
  end

  def new(conn, %{"character_id" => char_id, "story_id" => story_id}) do
    changeset = CharTag.changeset(%CharTag{}, %{})
    render conn, "new.html", changeset: changeset, char_id: char_id, story_id: story_id
  end

  def create(conn, %{"char_tag" => char_tag, "story_id" => story_id, "character_id" => char_id}) do
    IO.inspect(char_id)
    changeset = CharTag.changeset(%CharTag{}, char_tag)

    case Repo.insert(changeset) do
      {:ok, _story} ->
        conn
        |> put_flash(:info, "Your tag was successfully created")
        |> redirect(to: story_character_path(conn, :index, char_id))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => tag_id}) do
    char_tag = Repo.get(CharTag, tag_id)
    changeset = CharTag.changeset(char_tag)

    render conn, "edit.html", changeset: changeset, char_tag: char_tag
  end

  def update(conn, %{"id" => char_tag_id, "char_tag" => char_tag, "character_id" => char_id, "story_id" => story_id}) do
    old_char_tag = Repo.get(CharTag, char_tag_id)
    changeset = Story.changeset(old_char_tag, char_tag)

    case Repo.update(changeset) do
      {:ok, _story_tag} ->
        conn
        |> put_flash(:info, "Your tag was successfully updated")
        |> redirect(to: story_character_path(conn, :index, story_id))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, char_tag: old_char_tag, story_id: story_id
    end
  end

  def delete(conn, %{"id" => story_tag_id}) do
    Repo.get!(StoryTag, story_tag_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Your tag was successfully deleted")
    |> redirect(to: story_path(conn, :index))
  end
end
