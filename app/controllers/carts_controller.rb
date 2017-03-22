class CartsController < ApplicationController
  


  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_shoes = Shoe.find(cart_ids)
  end

  def add
    $redis.sadd current_user_cart, params[:shoe_id]
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.srem current_user_cart, params[:shoe_id]
    render json: current_user.cart_count, status: 200
  end

  private



  def current_user_cart

        unless logged_in?
      flash[:danger] = "Access denied."
       redirect_to root_path
     else 
    "cart#{current_user.id}"
    end
  end

end
