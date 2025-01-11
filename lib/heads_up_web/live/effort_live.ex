defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, responders: 0, minutes_per_responder: 10)}
  end

  def render(assigns) do
    ~H"""
    <div class="effort">
      <h1>Community Love</h1>
      <section>
        <button phx-click="add" phx-value-quantity="3">
          +3
        </button>
        <div>
          {@responders} Responders
        </div>
        &times;
        <div>
          {@minutes_per_responder} Minutes
        </div>
        =
        <div>
          {@responders * @minutes_per_responder} Minutes
        </div>
      </section>

      <form phx-submit="set-minutes-per-responder">
        <label>Minutes Per Responder:</label>
        <input type="number" name="minutes_per_responder" value={@minutes_per_responder} min="1" />
      </form>
    </div>
    """
  end

  def handle_event("add", %{"quantity" => quantity}, socket) do
    socket = update(socket, :responders, &(&1 + String.to_integer(quantity)))

    {:noreply, socket}
  end

  def handle_event(
        "set-minutes-per-responder",
        %{"minutes_per_responder" => minutes_per_responder},
        socket
      ) do
    socket = assign(socket, :minutes_per_responder, String.to_integer(minutes_per_responder))

    {:noreply, socket}
  end
end
