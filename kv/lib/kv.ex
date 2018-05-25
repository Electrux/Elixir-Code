defmodule KV do
  use Application
  @moduledoc """
  Documentation for KV.
  """

  @doc """
  Hello world.

  ## Examples

      iex> KV.hello
      :world

  """
  def start( _type, _args )do
    KV.Supervisor.start_link( name: KV.Supervisor )
  end
end
