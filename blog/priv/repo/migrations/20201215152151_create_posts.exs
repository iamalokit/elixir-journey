defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :published, :boolean, default: false, null: false
      add :slug, :string

      timestamps()
    end
    create unique_index(:posts, [:slug])
  end
end
