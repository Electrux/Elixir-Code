defmodule Learn.Genserver do
  use GenServer

  def start_link( opts ) do
    GenServer.start_link( __MODULE__, :ok, opts )
  end

  def push( pid, item ) do
    # cast because i don't need to wait for server
    GenServer.cast( pid, { :push, item } )
  end

  def pop( pid ) do
    GenServer.call( pid, :pop )
  end

  def size( pid ) do
    GenServer.call( pid, :size )
  end

  def at( pid, index ) do
    GenServer.call( pid, { :at, index } )
  end

  # Server

  def init( :ok ) do
    { :ok, [] }
  end

  def handle_call( what, _from, state ) do
    case what do
      :pop ->
	{ :reply, Enum.at( state, length( state ) - 1 ), List.delete_at( state, length( state ) - 1 ) }
      :size ->
	{ :reply, length( state ), state }
      { :at, index } ->
	{ :reply, Enum.at( state, index ), state }
      _ ->
	{ :reply, :error, state }
    end
  end

  def handle_cast( { :push, item }, state ) do
    { :noreply, state ++ [ item ] }
  end
end
