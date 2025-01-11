defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 2000)
    end

    socket =
      assign(socket,
        responders: 0,
        minutes_per_responder: 10
      )
      |> update_total_time_information()

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
    socket =
      update(
        socket,
        :responders,
        &(&1 + String.to_integer(quantity))
      )
      |> update_total_time_information()

    {:noreply, socket}
  end

  def handle_event(
        "set-minutes-per-responder",
        %{"minutes_per_responder" => minutes_per_responder},
        socket
      ) do
    socket =
      assign(socket, :minutes_per_responder, String.to_integer(minutes_per_responder))
      |> update_total_time_information()

    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 2000)

    socket =
      update(
        socket,
        :responders,
        &(&1 + 3)
      )
      |> update_total_time_information()

    {:noreply, socket}
  end

  defp update_total_time_information(socket) do
    responders = socket.assigns.responders
    minutes_per_responder = socket.assigns.minutes_per_responder

    total = responders * minutes_per_responder
    hours = div(total, 60)
    minutes = rem(total, 60)

    assign(socket,
      total_hours: hours,
      total_minutes: minutes
    )
  end
end
