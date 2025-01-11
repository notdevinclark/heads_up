defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    responders = 0
    minutes_per_responder = 10
    {total_hours, total_minutes} = total_time(responders, minutes_per_responder)

    socket =
      assign(socket,
        responders: responders,
        minutes_per_responder: 10,
        total_hours: total_hours,
        total_minutes: total_minutes
      )

    {:ok, socket}
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
        <div :if={@total_hours > 0}>
          {@total_hours} Hours
        </div>
        <div :if={@total_hours == 0 || @total_minutes > 0}>
          {@total_minutes} Minutes
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
    new_responder_count = socket.assigns.responders + String.to_integer(quantity)

    {total_hours, total_minutes} =
      total_time(new_responder_count, socket.assigns.minutes_per_responder)

    socket =
      assign(socket,
        responders: new_responder_count,
        total_hours: total_hours,
        total_minutes: total_minutes
      )

    {:noreply, socket}
  end

  def handle_event(
        "set-minutes-per-responder",
        %{"minutes_per_responder" => minutes_per_responder},
        socket
      ) do
    new_minutes = String.to_integer(minutes_per_responder)
    {total_hours, total_minutes} = total_time(socket.assigns.responders, new_minutes)

    socket =
      assign(socket,
        minutes_per_responder: new_minutes,
        total_hours: total_hours,
        total_minutes: total_minutes
      )

    {:noreply, socket}
  end

  defp total_time(responders, minutes_per_responders) do
    total = responders * minutes_per_responders
    hours = div(total, 60)
    minutes = rem(total, 60)
    {hours, minutes}
  end
end
