defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    { :ok, bucket } = KV.Bucket.start_link( [] )
    %{ bucket: bucket }
  end

  test "store values by key", %{ bucket: bucket } do
    assert KV.Bucket.get( bucket, "milk" ) == nil

    KV.Bucket.put( bucket, "milk", 5 )
    assert KV.Bucket.get( bucket, "milk" ) == 5
  end

  test "delete values by key", %{ bucket: bucket } do
    assert KV.Bucket.delete( bucket, "test" ) == nil

    KV.Bucket.put( bucket, "test", 10 )
    assert KV.Bucket.delete( bucket, "test" ) == 10
  end
end
