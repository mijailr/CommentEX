defmodule Comment.Crypto do
  @moduledoc """
  This module handle the crypto operations for calculate
  signatures and generate signed requests
  """

  @doc """
  Take a key and a payload to generate HMAC hash

  ## Examples
    iex> Comment.Crypto.calculate_signature("13fc0c0bdec", "Payload to generate")
    "727f9f2d493ddcad310d787eb3cdd4b9ff09fab9"
  """

  @spec calculate_signature(binary, binary) :: binary
  def calculate_signature(key, payload) do
    :sha
    |> :crypto.hmac(key, payload)
    |> Base.encode16()
    |> String.downcase()
  end
end
