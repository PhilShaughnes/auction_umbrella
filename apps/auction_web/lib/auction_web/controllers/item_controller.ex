defmodule AuctionWeb.ItemController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", items: Auction.list_items)
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", item: Auction.get_item(id))
  end

  def new(conn, _params) do
    render(conn, "new.html", item: Auction.new_item())
  end

  def create(conn, %{"item" => item_params}) do
    case Auction.insert_item(item_params) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, item} -> render(conn, "new.html", item: item)
    end
  end

  def edit(conn, %{"id" => id}) do
    render(conn, "edit.html", item: Auction.edit_item(id))
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Auction.get_item(id)
    case Auction.update_item(item, item_params) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, item} -> render(conn, "edit.html", item: item)
    end
  end
end
