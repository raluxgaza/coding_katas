require 'minitest/autorun'

class TestChop < MiniTest::Unit::TestCase
  ErrorCode = -1

  def chop(key, int_array)

    array = int_array.sort

    if array.empty?
      return ErrorCode
    elsif array.length <= 4
      array.each do |item|
        if item == key
          return array.find_index(item)
        end
      end
      return ErrorCode
    end

    start_index = array.length / 2

    if array[start_index] > key
      # iterate backwards to find value
      array.each_index do |index|
        if index <= start_index
          if array.fetch(index) == key
            return index
          end
        end
      end
      return ErrorCode
    elsif array[start_index] < key
      # iterate forward to find value
      array.each_index do |index|
        if index >= start_index
          if array.fetch(index) == key
            return index
          end
        end
      end
      return ErrorCode
    elsif array[start_index] == key
      array.find_index(key)
    else
      return ErrorCode
    end
  end

  # ==========
  # Test Cases
  # ==========
  def test_chop
    assert_equal(-1, chop(3, []))
    assert_equal(-1, chop(3, [1]))
    assert_equal(0,  chop(1, [1]))
    #
    assert_equal(0,  chop(1, [1, 3, 5]))
    assert_equal(1,  chop(3, [1, 3, 5]))
    assert_equal(2,  chop(5, [1, 3, 5]))
    assert_equal(-1, chop(0, [1, 3, 5]))
    assert_equal(-1, chop(2, [1, 3, 5]))
    assert_equal(-1, chop(4, [1, 3, 5]))
    assert_equal(-1, chop(6, [1, 3, 5]))
    #
    assert_equal(0,  chop(1, [1, 3, 5, 7]))
    assert_equal(1,  chop(3, [1, 3, 5, 7]))
    assert_equal(2,  chop(5, [1, 3, 5, 7]))
    assert_equal(3,  chop(7, [1, 3, 5, 7]))
    assert_equal(-1, chop(0, [1, 3, 5, 7]))
    assert_equal(-1, chop(2, [1, 3, 5, 7]))
    assert_equal(-1, chop(4, [1, 3, 5, 7]))
    assert_equal(-1, chop(6, [1, 3, 5, 7]))
    assert_equal(-1, chop(8, [1, 3, 5, 7]))
    assert_equal(4, chop(10, [1, 4, 6, 8, 10]))
    assert_equal(-1, chop(11, [1, 2, 4, 8, 10]))
    assert_equal(-1, chop(11, [1, 2, 4, 8, 10, 12, 14, 16, 18, 20]))
  end
end
