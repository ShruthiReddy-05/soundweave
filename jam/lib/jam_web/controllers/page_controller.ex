defmodule MyappWeb.PageController do
  use MyappWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end


  def first(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :first, layout: false)

  end

  def start(conn, _params) do
    render(conn, "start.html", layout: false)
  end

  def room(conn, _params) do
    render(conn, "room.html", layout: false)
  end

  def create_room(conn, _params) do
    # Generate a unique room code
    room_code = :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 6)

    # Send the code as a JSON response
    json(conn, %{room_code: room_code})
  end

  def join_room(conn, %{"code" => code}) do
    # Logic for handling the room code can go here
    # For now, just render the room page or redirect
    IO.puts("User joined room with code: #{code}")

    # Render a room page or redirect
    render(conn, "room.html", room_code: code,layout: false)
  end

end
