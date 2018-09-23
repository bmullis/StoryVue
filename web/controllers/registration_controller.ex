defmodule Storyvue.RegistrationController do
  use Storyvue.Web, :controller
  alias Storyvue.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Storyvue.Registration.create(changeset, Storyvue.Repo) do
      {:ok, changeset} ->
        conn
        |> put_session(:current_user, changeset.id)
        |> put_flash(:info, "Your account was successfully created")
        |> redirect(to: "/dashboard")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "We were unable to create your account at this time")
        |> render("new.html", changeset: changeset)
    end
  end
end
