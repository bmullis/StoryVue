defmodule Storyvue.SessionController do
  use Storyvue.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
    case Storyvue.Session.login(session_params, Storyvue.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "You were successfully logged in")
        |> redirect(to: "/dashboard")
      :error ->
        conn
        |> put_flash(:info, "You supplied an incorrect email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "You were logged out successfully")
    |> redirect(to: "/")
  end
end
