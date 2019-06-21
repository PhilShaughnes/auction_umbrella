defmodule AuctionWeb.UserController do
  use AuctionWeb, :controller

  def show(conn, %{"id" => id}) do
    render conn, "show.html", user: Auction.get_user(id)
  end

  def new(conn, _paraams) do
    render conn, "new.html", user: Auction.new_user()
  end

  def create(conn, %{"user" => user_params}) do
    case Auction.insert_user(user_params) do
      {:ok, user} -> redirect conn, to: Routes.user_path(conn, :show, user)
      {:error, user} -> render conn, "new.html", user: user
    end
  end
end
