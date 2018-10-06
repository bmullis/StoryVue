defmodule Storyvue.CharTag do
  use Storyvue.Web, :model

  schema "char_tags" do
    field :tag_title, :string
    field :tag_color, :string
    field :char_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:tag_title, :tag_color, :char_id])
    |> validate_required([:tag_title, :tag_color, :char_id])
  end
end
