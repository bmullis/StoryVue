defmodule Storyvue.Character do
  use Storyvue.Web, :model

  schema "characters" do
    field :char_name, :string
    field :char_image, :string
    field :char_date_of_birth, :date
    field :char_place_of_birth, :string
    field :char_education, :string
    field :char_school, :string
    field :char_occupation, :string
    field :char_description, :string
    field :char_desire, :string
    field :story_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:char_name, :char_image, :char_date_of_birth, :char_place_of_birth, :char_education, :char_school, :char_occupation, :char_description, :char_desire, :story_id])
    |> validate_required([:char_name, :story_id])
  end
end
