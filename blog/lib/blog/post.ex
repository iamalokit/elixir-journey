defmodule Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :body, :string
    field :published, :boolean, default: false
    field :slug, :string
    field :title, :string

    timestamps()
  end

  #Generating private functions
  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, Slugger.slugify_downcase(title))
    else
      changeset
    end
  end
  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :published])
    |> validate_required([:title, :body, :published])
    |> slugify_title()
    |> unique_constraint(:slug, message: "There was a problem generating a unique slug for this post. Please ensure that title is not already taken.")
  end

  defimpl Phoenix.Param, for: Blog.Posts.Post do
    def to_param(%{slug: slug}),  do: slug
  end

end
