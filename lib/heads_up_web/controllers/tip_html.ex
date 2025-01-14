defmodule HeadsUpWeb.TipHTML do
  @moduledoc """
  This module contains pages rendered by TipController.

  See the `tip_html` directory for all templates available.
  """
  use HeadsUpWeb, :html

  embed_templates "tip_html/*"

  def show(assigns) do
    ~H"""
    <div class="tips">
      <h1>You Like a Tip, {@answer}</h1>
      <p>
        {@tip.text}
      </p>
    </div>
    <div class="mt-10">
      <.link navigate={~p"/tips"}>← Back</.link>
    </div>
    """
  end
end
