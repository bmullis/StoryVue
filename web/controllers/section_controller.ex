defmodule Storyvue.SectionController do
  use Storyvue.Web, :controller
  alias Storyvue.Section

  def index(conn, %{"story_id" => story_id}) do
    section_query = from s in Section, where: s.story_id == ^story_id
    sections = Repo.all(section_query)
    render conn, "index.html", sections: sections, story_id: story_id
  end

  def new(conn, %{"story_id" => story_id}) do
    changeset = Section.changeset(%Section{}, %{})
    render conn, "new.html", changeset: changeset, story_id: story_id
  end

  def create(conn, %{"section" => section, "story_id" => story_id}) do
    changeset = Section.changeset(%Section{}, section)

    case Repo.insert(changeset) do
      {:ok, _note} ->
        conn
        |> put_flash(:info, "Your section was successfully created")
        |> redirect(to: story_path(conn, :show, story_id))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  """
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
  """
end
