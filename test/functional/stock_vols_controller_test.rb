require 'test_helper'

class StockVolsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => StockVol.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    StockVol.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    StockVol.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to stock_vol_url(assigns(:stock_vol))
  end

  def test_edit
    get :edit, :id => StockVol.first
    assert_template 'edit'
  end

  def test_update_invalid
    StockVol.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StockVol.first
    assert_template 'edit'
  end

  def test_update_valid
    StockVol.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StockVol.first
    assert_redirected_to stock_vol_url(assigns(:stock_vol))
  end

  def test_destroy
    stock_vol = StockVol.first
    delete :destroy, :id => stock_vol
    assert_redirected_to stock_vols_url
    assert !StockVol.exists?(stock_vol.id)
  end
end
