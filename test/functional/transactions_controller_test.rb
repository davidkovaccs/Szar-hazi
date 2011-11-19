require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Transaction.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Transaction.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Transaction.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to transaction_url(assigns(:transaction))
  end

  def test_edit
    get :edit, :id => Transaction.first
    assert_template 'edit'
  end

  def test_update_invalid
    Transaction.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Transaction.first
    assert_template 'edit'
  end

  def test_update_valid
    Transaction.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Transaction.first
    assert_redirected_to transaction_url(assigns(:transaction))
  end

  def test_destroy
    transaction = Transaction.first
    delete :destroy, :id => transaction
    assert_redirected_to transactions_url
    assert !Transaction.exists?(transaction.id)
  end
end
