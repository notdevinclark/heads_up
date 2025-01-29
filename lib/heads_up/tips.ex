defmodule HeadsUp.Tips do
  alias HeadsUp.Repo
  alias HeadsUp.Tips.Tip

  def list_tips() do
    Repo.all(Tip)
  end

  def get_tip(id) do
    Repo.get(Tip, id)
  end
end
