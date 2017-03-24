class StaticPagesController < ApplicationController
	  before_action :set_shoe, only: [:show, :edit, :update, :destroy, :all_shoe]

  def home

  	 if params[:query].present?
      @shoes = Shoe.search_full_text(params[:query]).page params[:page]
    elsif params[:category_id]
      respond_to do |format|
      format.js
      format.html
    end
      @shoes = Category.find(params[:category_id]).shoes.page params[:page]
    else
      @shoes = Shoe.all.order(:brand).page params[:page]
    end
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
