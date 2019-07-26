defmodule AuctionWeb.ItemResolver do
  def items(_parent, _args, _resolution) do
    {:ok, Auction.list_items}
  end

  def item(_parent, %{id: id}, _resolution) do
    {:ok, Auction.get_item(id)}
  end

end
