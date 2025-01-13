defmodule HeadsUp.Tips do
  def list_tips() do
    [
      %{
        id: 1,
        text: "Seven Up 7️⃣⬆️"
      },
      %{
        id: 2,
        text: "Make Tip Number 1 Yours 👕"
      },
      %{
        id: 3,
        text: "Slow is smooth, and smooth is fast! 🐢"
      },
      %{
        id: 4,
        text: "Working with a buddy is always a smart move. 👯"
      },
      %{
        id: 5,
        text: "Take it easy and enjoy! 😊"
      }
    ]
  end

  def get_tip(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> get_tip()
  end

  def get_tip(id) when is_integer(id) do
    list_tips()
    |> Enum.find(fn tip ->
      tip.id == id
    end)
  end
end
