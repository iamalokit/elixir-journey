defmodule LiveChatWeb.RoomChannel do
  use LiveChatWeb, :channel
  alias LiveChatWeb.Presence

  def join("room:lobby", _, socket) do
    send self(), :after_join
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def connect(%{"user" => user}, socket) do
    {:ok, assign(socket, :user, user)}
  end
end
