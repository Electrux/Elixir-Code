defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!( KV.Registry )
    %{ registry: registry }
  end

  test "spawn bucket", %{ registry: registry } do
    assert KV.Registry.lookup( registry, "shopping" ) == :error

    KV.Registry.create( registry, "shopping" )
    assert { :ok, bucket } = KV.Registry.lookup( registry, "shopping" )

    KV.Bucket.put( bucket, "milk", 5 )
    assert KV.Bucket.get( bucket, "milk" ) == 5
  end

  test "remove buckets on exit", %{ registry: registry } do
    KV.Registry.create( registry, "shopping" )
    { :ok, bucket } = KV.Registry.lookup( registry, "shopping" )
    Agent.stop( bucket )
    assert KV.Registry.lookup( registry, "shopping" ) == :error
  end
end
