defmodule Storyvue.StoryController do
  use Storyvue.Web, :controller
  alias Storyvue.Story

  def index(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user)
    story_query = from s in Story, where: s.user_id == ^current_user_id
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
end
