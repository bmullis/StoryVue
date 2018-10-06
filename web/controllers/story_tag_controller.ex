defmodule Storyvue.StoryTagController do
  use Storyvue.Web, :controller
  alias Storyvue.StoryTag

  def index(conn, %{"story_id" => story_id}) do
    tag_query = from t in Storyvue.StoryTag, where: t.story_id == ^story_id
    tags = Repo.all(tag_query)
    render conn, "index.html", tags: tags, story_id: story_id
  end

  def new(conn, %{"story_id" => story_id}) do
    changeset = StoryTag.changeset(%StoryTag{}, %{})
    render conn, "new.html", changeset: changeset, story_id: story_id
  end

  def create(conn, %{"story_tag" => story_tag}) do
    changeset = StoryTag.changeset(%StoryTag{}, story_tag)

    case Repo.insert(changeset) do
      {:ok, _story} ->
        conn
        |> put_flash(:info, "Your tag was successfully created")
        |> redirect(to: story_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => tag_id}) do
    story_tag = Repo.get(StoryTag, tag_id)
    changeset = StoryTag.changeset(story_tag)

    render conn, "edit.html", changeset: changeset, story_tag: story_tag
  end

  def update(conn, %{"id" => story_tag_id, "story_tag" => story_tag, "story_id" => story_id}) do
    old_story_tag = Repo.get(StoryTag, story_tag_id)
    changeset = Story.changeset(old_story_tag, story_tag)

    case Repo.update(changeset) do
      {:ok, _story_tag} ->
        conn
        |> put_flash(:info, "Your tag was successfully updated")
        |> redirect(to: story_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, story_tag: old_story_tag, story_id: story_id
    end
  end

  def delete(conn, %{"id" => story_tag_id}) do
    Repo.get!(StoryTag, story_tag_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Your tag was successfully deleted")
    |> redirect(to: story_path(conn, :index))
  end
end
