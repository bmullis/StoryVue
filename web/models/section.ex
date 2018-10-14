defmodule Storyvue.Section do
  use Storyvue.Web, :model
  alias Storyvue.Moment

  schema "sections" do
    field :title, :string
    field :description, :string
    field :order, :integer
    field :story_id, :integer
    has_many :moments, Moment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :order, :story_id])
    |> validate_required([:title, :description, :story_id])
  end
end
