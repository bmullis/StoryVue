defmodule Storyvue.DashboardController do
  use Storyvue.Web, :controller

  def index(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user)
    story_query = from s in Storyvue.Story, where: s.user_id == ^current_user_id
    stories = Repo.all(story_query)
    render conn, "index.html", stories: stories
  end
end
