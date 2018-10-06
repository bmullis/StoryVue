defmodule Storyvue.StoryTag do
  use Storyvue.Web, :model

  schema "story_tags" do
    field :tag_title, :string
    field :tag_color, :string
    field :story_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:tag_title, :tag_color, :story_id])
    |> validate_required([:tag_title, :tag_color, :story_id])
  end
end
