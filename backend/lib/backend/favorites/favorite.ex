defmodule Backend.Favorites.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do
    field :pairword, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:pairword])
    |> validate_required([:pairword])
  end
end
