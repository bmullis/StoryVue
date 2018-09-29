defmodule Storyvue.AccountController do
  use Storyvue.Web, :controller

  def index(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user)
    user_query = from u in Storyvue.User, where: u.id == ^current_user_id
    user = Repo.all(user_query)
    render conn, "index.html", user: user
  end

  def edit(conn, %{"id" => current_user_id}) do
    user = Repo.get(Storyvue.User, current_user_id)
    changeset = Storyvue.User.changeset(user)

    render conn, "edit.html", changeset: changeset, user: user
  end

  def update(conn, %{"id" => user_id, "user" => user}) do
    old_user = Repo.get(Storyvue.User, user_id)
    changeset = Storyvue.User.changeset(old_user, user)

    case Repo.update(changeset) do
      {:ok, _payment} ->
        conn
        |> put_flash(:info, "Your account was successfully updated")
        |> redirect(to: account_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, user: old_user
    end
  end
end
