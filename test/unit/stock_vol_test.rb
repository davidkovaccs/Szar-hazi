require 'test_helper'

class StockVolTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert StockVol.new.valid?
  end
end
