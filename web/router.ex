defmodule Storyvue.Router do
  use Storyvue.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Storyvue do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/registration", RegistrationController, only: [:new, :create]

    resources "/stories", StoryController do
      resources "/sections", SectionController do
        resources "/moments", MomentController
      end
      resources "/characters", CharacterController do
        resources "/tags", CharTagController, only: [:index, :new, :create, :edit, :update, :delete]
      end
      resources "/tags", StoryTagController, only: [:index, :new, :create, :edit, :update, :delete]
      resources "/notes", NoteController, only: [:index, :new, :create]
    end

    get "/login",  SessionController, :new
    post "/login",  SessionController, :create
    delete "/logout", SessionController, :delete

    get "/dashboard", DashboardController, :index

    get "/account", AccountController, :index
    get "/account/:id/edit", AccountController, :edit
    put "/account/:id", AccountController, :update
    delete "/account/:id", AccountController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Storyvue do
  #   pipe_through :api
  # end
end
