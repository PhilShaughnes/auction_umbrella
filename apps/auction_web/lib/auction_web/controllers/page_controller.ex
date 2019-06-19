defmodule AuctionWeb.PageController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", items: Auction.list_items)
  end
end

