defmodule DashPhxWeb.PageController do
  use DashPhxWeb, :controller
  require Logger

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def capture(conn, _params) do
    case File.read("/tmp/capture.ppm") do
      {:ok, file} ->
        conn
        |> Plug.Conn.send_resp(200, file)

      error ->
        Logger.warn("Unable to read capture.ppm file: #{inspect(error)}")

        conn
        |> Plug.Conn.send_resp(404, "Unable to find")
    end
  end
end
