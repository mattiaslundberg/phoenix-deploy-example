defmodule HelloReleaseWeb.HeartbeatChannel do
  use Phoenix.Channel

  def join("heartbeat:listen", _message, socket) do
    IO.puts "Listen"
    send(self(), :after_join) # send a message to kick off our loop. We do this in order to take as little time as possible on the server before we send the client socket an :ok message signaling a good connection.
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    IO.puts "AFTER join"
    send(self(), {:beat, 0}) # initialize our heartbeat broadcast with an initial state of 0
    {:noreply, socket}
  end

  def handle_info({:beat, i}, socket) do
    IO.puts "broadcast it!"
    broadcast!(socket, "ping", %{body: i}) # broadcast the current heartbeat number to all connected clients
    Process.send_after(self(), {:beat, i + 1}, 2000) # send a message to the current server with a new (even numbered) state after 2 seconds
    {:noreply, socket}
  end

end
