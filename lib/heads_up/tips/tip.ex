defmodule HeadsUp.Tips.Tip do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tips" do
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tip, attrs) do
    tip
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
