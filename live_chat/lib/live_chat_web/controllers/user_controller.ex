defmodule LiveChatWeb.UserController do
  use LiveChatWeb, :controller
  alias LiveChat.User
  alias LiveChat.Repo

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end
end
