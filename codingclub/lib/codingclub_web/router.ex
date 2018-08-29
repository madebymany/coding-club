defmodule CodingclubWeb.Router do
  use CodingclubWeb, :router

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

  scope "/", CodingclubWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/", PageController, :index
    resources "/terms", TermController
    resources "/lessons", LessonController
    resources "/groups", GroupController
    resources "/subjects", SubjectController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CodingclubWeb do
  #   pipe_through :api
  # end
end
