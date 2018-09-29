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
      resources "/characters", CharacterController
    end

    get "/login",  SessionController, :new
    post "/login",  SessionController, :create
    delete "/logout", SessionController, :delete

    get "/dashboard", DashboardController, :index
    get "/account", AccountController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Storyvue do
  #   pipe_through :api
  # end
end
