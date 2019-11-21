defmodule Comment.Server do
  @moduledoc """
  This module handle the server HTTP requests
  """
  require Logger
  use Plug.Router
  use Plug.ErrorHandler

  alias Comment.{Github, BodyReader}

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    body_reader: {BodyReader, :read_body, []},
    json_decoder: Jason
  )

  plug(Github.VerifyRequest, paths: ["/webhook/github"])

  plug(:dispatch)

  post "/webhook/github" do
    conn
    |> get_req_header("x-github-event")
    |> List.first()
    |> Github.handle_request(conn.params)

    send_resp(conn, 200, get_req_header(conn, "x-hub-signature"))
  end

  post "/:platform/:user/:repo/" do
    send_resp(conn, 200, "hello #{user}")
  end

  match _ do
    send_resp(conn, 404, "")
  end

  def handle_errors(conn, _) do
    send_resp(conn, conn.status, "")
  end
end
