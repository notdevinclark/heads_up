defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 2000)
    end

    socket =
      assign(socket,
        responders: 0,
        minutes_per_responder: 10,
        page_title: "Effort"
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
        = <.total_time responders={@responders} minutes_per_responder={@minutes_per_responder} />
      </section>

      <.set_minute_form
        minutes_per_responder={@minutes_per_responder}
        phx-submit="set-minutes-per-responder"
      />
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

    {:noreply, socket}
  end

  def handle_event(
        "set-minutes-per-responder",
        %{"minutes_per_responder" => minutes_per_responder},
        socket
      ) do
    socket =
      assign(socket, :minutes_per_responder, String.to_integer(minutes_per_responder))

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

    {:noreply, socket}
  end

  attr :responders, :integer, required: true
  attr :minutes_per_responder, :integer, required: true

  def total_time(assigns) do
    total = assigns.responders * assigns.minutes_per_responder

    assigns =
      assign(assigns,
        hours: div(total, 60),
        minutes: rem(total, 60)
      )

    ~H"""
    <div :if={@hours > 0}>
      {@hours} Hours
    </div>
    <div :if={@hours == 0 || @minutes > 0}>
      {@minutes} Minutes
    </div>
    """
  end

  attr :minutes_per_responder, :integer, required: true
  attr :rest, :global

  def set_minute_form(assigns) do
    ~H"""
    <form {@rest}>
      <label>Minutes Per Responder:</label>
      <input type="number" name="minutes_per_responder" value={@minutes_per_responder} min="1" />
    </form>
    """
  end
end
