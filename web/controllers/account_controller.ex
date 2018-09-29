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

  def delete(conn, %{"id" => user_id}) do
    story_query = from s in Storyvue.Story, where: s.user_id == ^user_id
    stories = Repo.all(story_query)
      for story <- stories do
        character_query = from c in Storyvue.Character, where: c.story_id == ^story.id
        characters = Repo.all(character_query)
          for character <- characters do
            Repo.get!(Storyvue.Character, character.id)
            |> Repo.delete!
          end
        Repo.get!(Storyvue.Story, story.id)
        |> Repo.delete!
      end
    Repo.get!(Storyvue.User, user_id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Your Account was successfully deleted")
    |> redirect(to: page_path(conn, :index))
  end
end
