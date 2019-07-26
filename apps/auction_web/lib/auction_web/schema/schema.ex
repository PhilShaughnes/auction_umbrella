defmodule AuctionWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  query do
    @desc "Get list of items"
    field :items, list_of(:item) do
      resolve &AuctionWeb.ItemResolver.items/3
    end

    @desc "Get an item by its id"
    field :item, :item do
      arg :id, non_null(:id)
      resolve &AuctionWeb.ItemResolver.item/3
    end
  end

  object :item do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :description, :string
    field :ends_at, :datetime
  end
end
