defmodule Comment.BodyReader do
  @moduledoc """
  Used for store a raw copy of the request body before be
  processed by Plug.Parsers to be used in the signature verification.
  """
  alias Plug.Conn

  @spec read_body(Conn.t(), Keyword.t()) :: {:ok, binary, Conn.t()} | {:error, Conn.term()}
  def read_body(%Conn{} = conn, opts) do
    {:ok, body, conn} = Conn.read_body(conn, opts)
    conn = update_in(conn.assigns[:raw_body], &[body | &1 || []])
    {:ok, body, conn}
  end
end
