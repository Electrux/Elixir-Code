defmodule SelectionSort do
  def sort( list ) when is_list( list ) do
    internal_sort( 0, list, length( list ) )
  end

  def internal_sort( i, list, list_size ) do
    # last element is automatically sorted
    # since all the others are
    if i >= list_size - 1 do
      list
    else
      loc = find_min_loc( i, list, length( list ), i )
      if loc != i do
	internal_sort( i + 1, swap( list, loc, i ), list_size )
      else
	internal_sort( i + 1, list, list_size )
      end
    end
  end

  def find_min_loc( loc, list, list_len, at ) do
    cond do
      at >= list_len ->
	loc
      Enum.at( list, loc ) >= Enum.at( list, at ) ->
	find_min_loc( at, list, list_len, at + 1 )
      true ->
	find_min_loc( loc, list, list_len, at + 1 )
    end
  end

  def swap( list, loc1, loc2 ) do
    val1 = Enum.at( list, loc1 )
    List.replace_at( list, loc1, Enum.at( list, loc2 ) ) |> List.replace_at( loc2, val1 )
  end
end

IO.inspect SelectionSort.sort( [ 15, 12, 5, 1, 6, 7, 291, 251 ] )
