defmodule ToyShortener.Logger do
  use GenServer
  require Logger

  @name __MODULE__

  def start_link do
    GenServer.start_link(@name, [], name: @name)
  end

  def init(state) do
    Logger.info("Starting visit logger")
    {:ok, state}
  end

  def record_visit(link, visitor_info) do
    GenServer.cast(@name, {:visit, {link, visitor_info}})
  end

  def handle_cast({:visit, {link, visitor_info}}, state) do
    ToyShortener.record_visit(link, visitor_info, :sync)
    {:noreply, state}
  end
end
