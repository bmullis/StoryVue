defmodule Storyvue.Moment do
  use Storyvue.Web, :model
  alias Storyvue.Character

  schema "moments" do
    field :title, :string
    field :content, :string
    field :order, :integer
    field :section_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content, :order, :section_id])
    |> validate_required([:title, :content, :section_id])
  end
end
