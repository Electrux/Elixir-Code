defmodule Learn.GenserverTest do
  use ExUnit.Case, async: true

  setup do
    gs = start_supervised!( Learn.Genserver )
    %{ genserver: gs }
  end

  test "push test", %{ genserver: gs } do
    assert Learn.Genserver.size( gs ) == 0

    Learn.Genserver.push( gs, 5 )
    assert Learn.Genserver.size( gs ) == 1
  end

  test "pop test", %{ genserver: gs } do
    assert Learn.Genserver.size( gs ) == 0

    Learn.Genserver.push( gs, 5 )
    assert Learn.Genserver.pop( gs ) == 5
  end

  test "at test", %{ genserver: gs } do
    assert Learn.Genserver.size( gs ) == 0

    Learn.Genserver.push( gs, 5 )
    assert Learn.Genserver.at( gs, 1 ) == nil
    assert Learn.Genserver.at( gs, 0 ) == 5
  end
end
