defmodule Storyvue.Story do
  use Storyvue.Web, :model
  alias Storyvue.Character
  alias Storyvue.StoryTag
  alias Storyvue.Section

  schema "stories" do
    field :title, :string
    field :description, :string
    field :user_id, :integer
    has_many :sections, Section
    has_many :characters, Character
    has_many :story_tags, StoryTag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :user_id])
    |> validate_required([:title, :description, :user_id])
  end
end
