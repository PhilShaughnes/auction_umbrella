defmodule AuctionWeb.Router do
  use AuctionWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AuctionWeb.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuctionWeb do
    pipe_through :browser

    get "/", ItemController, :index
    resources "/items", ItemController, only: [
      :index,
      :show,
      :new,
      :create,
      :edit,
      :update
    ] do
      resources "/bids", BidController, only: [:create]
    end

    resources "/users", UserController, only: [
      :show,
      :new,
      :create
    ]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/json", AuctionWeb.Api do
    pipe_through :api

    resources "/items", ItemController, only: [:index, :show]
  end

  scope "/gql" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: AuctionWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: AuctionWeb.Schema,
      interface: :playground
  end
end
