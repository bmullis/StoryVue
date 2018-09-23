defmodule Storyvue.DashboardController do
  use Storyvue.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
