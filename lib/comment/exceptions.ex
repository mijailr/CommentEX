defmodule Comment.HTTPBadRequest do
  @moduledoc """
  Define NotAuthorized exception
  """
  defexception message: "BadRequest", plug_status: 400
end

defmodule Comment.HTTPNotAuthorized do
  @moduledoc """
  Define NotAuthorized exception
  """
  # , plug_status: 401
  defexception message: "NotAuthorized", plug_status: 401
end
