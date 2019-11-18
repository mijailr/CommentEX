defmodule Comment.Server do
  require Logger
  use Plug.Router

  alias Comment.RequestReader

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    body_reader: {RequestReader, :read_body, []},
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/" do
    [signature] = get_req_header(conn, "x-hub-signature")
    payload = conn.assigns.raw_body
    {response, _payload} = Comment.Github.handle_payload(payload, signature)
    Logger.info(response)
    send_resp(conn, 200, "pong")
  end

  get "/:platform/:user/:repo/:branch" do
    send_resp(conn, 200, "hello #{user}")
  end
end
