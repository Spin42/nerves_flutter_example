defmodule BackendWeb.FavoriteController do
  use BackendWeb, :controller

  alias Backend.Favorites
  alias Backend.Favorites.Favorite

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    favorites = Favorites.list_favorites()
    render(conn, :index, favorites: favorites)
  end

  def create(conn, %{"favorite" => favorite_params}) do
    with {:ok, %Favorite{} = favorite} <- Favorites.create_favorite(favorite_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/favorites/#{favorite}")
      |> render(:show, favorite: favorite)
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Favorites.get_favorite!(id)

    with {:ok, %Favorite{}} <- Favorites.delete_favorite(favorite) do
      send_resp(conn, :no_content, "")
    end
  end
end
