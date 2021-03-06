defmodule KV.Bucket do
  use Agent

  @doc """
  Starts a new bucket
  """
  def start_link( _opts ) do
    Agent.start_link( fn -> %{} end )
  end

  @doc """
  Gets a value from bucket by key
  """
  def get( bucket, key ) do
    Agent.get( bucket, & Map.get( &1, key ) )
  end

  @doc """
  Puts the value for given key in a bucket
  """
  def put( bucket, key, value ) do
    Agent.update( bucket, & Map.put( &1, key, value ) )
  end

  @doc """
  Deletes key from bucket and fetches
  the key value if it exists
  """
  def delete( bucket, key ) do
    Agent.get_and_update( bucket, & Map.pop( &1, key ) )
  end
end
