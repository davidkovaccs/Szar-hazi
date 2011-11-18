require 'test_helper'

class StockTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Stock.new.valid?
  end
end
