defmodule JamWeb.Router do
  use JamWeb, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JamWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JamWeb do
    pipe_through :browser

    get "/", PageController, :start
    get "/room", PageController, :room
    get "/create_room", PageController, :create_room
    get "/room/:code", PageController, :join_room
  end

    /get "/the_song", Audio, :song

  scope "/api", JamWeb do
    pipe_through :api

    # post "/tracks", TrackController, :upload
    # put "/tracks/:id/play", TrackController, :play
    # put "/tracks/:id/pause", TrackController, :pause
    # put "/tracks/:id/stop", TrackController, :stop
  end
  # Other scopes may use custom stacks.
  # scope "/api", MyappWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:jam, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JamWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
