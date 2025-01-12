defmodule HeadsUpWeb.CustomComponents do
  use HeadsUpWeb, :html

  attr :status, :atom, required: true, values: [:canceled, :pending, :resolved]
  attr :class, :string, default: nil

  def badge(assigns) do
    ~H"""
    <div class={[
      "rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border",
      @status == :resolved && "text-lime-600 border-lime-600",
      @status == :pending && "text-amber-600 amber-lime-600",
      @status == :canceled && "text-gray-600 border-gray-600",
      @class
    ]}>
      {@status}
    </div>
    """
  end

  slot :inner_block, required: true
  slot :taglines

  def headline(assigns) do
    assigns = assign(assigns, :emoji, ~w(😎 🫡 🤯) |> Enum.random())

    ~H"""
    <div class="headline">
      <h1>
        {render_slot(@inner_block)}
      </h1>
      <div :for={taglines <- @taglines} class="tagline">
        {render_slot(taglines, @emoji)}
      </div>
    </div>
    """
  end
end
