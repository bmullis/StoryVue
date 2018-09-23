defmodule Storyvue.Story do
  use Storyvue.Web, :model

  schema "stories" do
    field :title, :string
    field :description, :string
    field :user_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :user_id])
    |> unique_constraint(:title)
    |> validate_required([:title, :description, :user_id])
  end
end
