defmodule BackendWeb.FavoriteController do
  use BackendWeb, :controller

  alias Backend.Favorites
  alias Backend.Favorites.Favorite

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    favorites = Favorites.list_favorites()
    render(conn, :index, favorites: favorites)
  end

  def create(conn, %{"wordpair" => wordpair}) do
    case Favorites.get_favorite_by_wordpair!(wordpair) do
      favorite = %Favorite{} ->
        {:ok, favorite} = Favorites.delete_favorite(favorite)
        conn
        |> put_status(:accepted)
        |> put_resp_header("location", ~p"/api/favorites/#{favorite}")
        |> render(:show, favorite: favorite)
      nil ->
        with {:ok, %Favorite{} = favorite} <- Favorites.create_favorite(%{wordpair: wordpair}) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", ~p"/api/favorites/#{favorite}")
          |> render(:show, favorite: favorite)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Favorites.get_favorite!(id)

    with {:ok, %Favorite{}} <- Favorites.delete_favorite(favorite) do
      send_resp(conn, :no_content, "")
    end
  end
end
