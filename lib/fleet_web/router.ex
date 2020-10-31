defmodule FleetWeb.Router do
  use FleetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JSONAPI.Deserializer
  end

  pipeline :auth do
    plug FleetWeb.Authentication.Pipeline
  end

  scope "/api", FleetWeb do
    resources "/tokens", TokenController, only: [:create]
  end

  scope "/api", FleetWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
  end

  scope "/api", FleetWeb do
    pipe_through [:api, :auth]

    resources "/users", UserController, except: [:create]
    resources "/locations", LocationController, except: [:show, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FleetWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FleetWeb.Telemetry
    end
  end
end
