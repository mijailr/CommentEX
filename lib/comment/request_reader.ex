defmodule Comment.RequestReader do
  @moduledoc """
  This module create an Plug body parser to have access
  to the raw body
  """

  @doc """
  Receive a connection and options to create a raw body inside the
  conn.assings
  """

  @spec read_body(Plug.t(), Keyword.t()) :: Plug.t()
  def read_body(conn, opts) do
    {:ok, body, conn} = Plug.Conn.read_body(conn, opts)
    conn = update_in(conn.assigns[:raw_body], &[body | &1 || []])
    {:ok, body, conn}
  end
end
