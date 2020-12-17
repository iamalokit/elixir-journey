defmodule BlogWeb.PostController do
  @moduledoc """
  Provide controller actions for working with blog posts
  """

  use BlogWeb, :controller
  alias BlogWeb.Router.Helpers
  alias Blog.Post
  alias Blog.Posts

  # Make sure the user is logged in when attempting to access the restricted routes
  plug :authenticate_user when action in [:new, :create, :edit, :update, :delete]
end
