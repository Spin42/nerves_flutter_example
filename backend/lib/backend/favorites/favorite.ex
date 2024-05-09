defmodule Backend.Favorites.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do
    field :wordpair, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:wordpair])
    |> validate_required([:wordpair])
  end
end
