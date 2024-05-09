defmodule BackendWeb.FavoriteJSON do
  alias Backend.Favorites.Favorite

  @doc """
  Renders a list of favorites.
  """
  def index(%{favorites: favorites}) do
    %{data: for(favorite <- favorites, do: data(favorite))}
  end

  @doc """
  Renders a single favorite.
  """
  def show(%{favorite: favorite}) do
    %{data: data(favorite)}
  end

  defp data(%Favorite{} = favorite) do
    %{
      id: favorite.id,
      wordpair: favorite.wordpair
    }
  end

  defp data(nil = favorite) do
    %{}
  end
end
