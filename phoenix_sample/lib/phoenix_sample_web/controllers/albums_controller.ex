defmodule PhoenixSampleWeb.AlbumsController do
  alias PhoenixSample.{Repo, Album} # <--- 1
  use PhoenixSampleWeb, :controller
  import Ecto.Query # <--- 2

  def index(conn, _params) do
    render conn, "index.html",
    albums: Repo.all(from a in Album,
    select: %{:name => a.name, :singer => a.singer, :tracks => a.track_count}) # <--- 3
  end
end
