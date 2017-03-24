class ShoesController < ApplicationController
  before_action :set_shoe, only: [:show, :edit, :update, :destroy, :all_shoe]
  # GET /shoes
  # GET /shoes.json
  def index

    if params[:query].present?
      @shoes = Shoe.search_full_text(params[:query]).page params[:page]
    elsif params[:category_id]
      respond_to do |format|
      format.js
      format.html
    end
      @shoes = Category.find(params[:category_id]).shoes.page params[:page]
    else
      @shoes = Shoe.all.page params[:page]
    end
  end



  # GET /shoes/1
  # GET /shoes/1.json
  def show
    @shoe = Shoe.find(params[:id])
    @cart_action = @shoe.cart_action current_user.try :id
  end

  # GET /shoes/new
  def new
    @shoe = Shoe.new
  end

  # GET /shoes/1/edit
  def edit
    unless current_user.try(:admin?)
      unless logged_in? and current_user.id == @shoe.user_id
        redirect_to root_path, :alert => "Access denied."
      end
    end
  end

  # POST /shoes
  # POST /shoes.json
  def create
    @shoe = current_user.shoes.new(shoe_params)

      if @shoe.save
         flash[:notice] = "Shoe was successfully created."
         redirect_to @shoe
      else
        flash[:danger] = "Shoe was not successfully created."
        render new
      end
    end
  

  # PATCH/PUT /shoes/1
  # PATCH/PUT /shoes/1.json
  def update
      if @shoe.update(shoe_params)
        flash[:notice] = "Shoe was successfully updated."
        redirect_to @shoe
      else
        flash[:danger] = "Shoe was not successfully updated."
        render :edit
      end
    end
  

  # DELETE /shoes/1
  # DELETE /shoes/1.json
  def destroy
    @shoe.destroy
    respond_to do |format|
      format.html { redirect_to shoes_url, notice: 'Shoe was successfully deleted.' }
      format.json { head :no_content }
    end
  end


  def all_shoe
      @shoes = Shoe.all
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe
      @shoe = Shoe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shoe_params
      params.require(:shoe).permit(:name, :brand, :shoe_size, :price, :description, category_ids:[], photos:[])
    end

end
