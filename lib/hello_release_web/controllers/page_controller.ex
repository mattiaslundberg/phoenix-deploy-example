defmodule HelloReleaseWeb.PageController do
  use HelloReleaseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
