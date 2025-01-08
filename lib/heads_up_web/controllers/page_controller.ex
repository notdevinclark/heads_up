defmodule HeadsUpWeb.PageController do
  use HeadsUpWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    message = conn.assigns.answer

    type =
      case message do
        "Yes" -> :info
        "Maybe" -> :warning
        "No" -> :error
      end

    conn
    |> put_flash(type, message)
    |> render(:home, layout: false)
  end
end
