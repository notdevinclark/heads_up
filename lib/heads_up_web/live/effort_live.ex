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
    </div>
    """
  end
end
