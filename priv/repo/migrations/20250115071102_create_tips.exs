defmodule HeadsUp.Repo.Migrations.CreateTips do
  use Ecto.Migration

  def change do
    create table(:tips) do
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
