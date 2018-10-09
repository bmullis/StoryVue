defmodule Storyvue.Note do
  use Storyvue.Web, :model

  schema "notes" do
    field :title, :string
    field :content, :string
    field :order, :integer
    field :story_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content, :order, :story_id])
    |> validate_required([:content, :story_id])
  end
end
