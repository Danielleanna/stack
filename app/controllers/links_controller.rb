class LinksController < ApplicationController

	#Before EVERYTHING in here, find the category
	before_action :get_category

  #Before EDIT, UPDTAE and DESTROY, find the link
  before_action :get_link, only: [:edit, :update, :destroy]

  def new

    if params[:duplicate_id].present?
      #do a duplicate of this
      @duplicate_link = @category.links.find(params[:duplicate_id])
      @link = @category.links.new(@duplicate_link.attributes)
    else
      #do a brand new one
      @link = @category.links.new
    end
 	  

  end
 

  def create
  	@link = @category.links.new(link_params)

  	if @link.save
  		flash[:success] = "Link added"
  		redirect_to category_path(@category)
  		
  	else
  		render :new

  	end
  end


  def edit
    
  end



  def update

    if @link.update(link_params)
      flash[:success] = "Link as updated"
      redirect_to category_path(@category)
    else
      render :edit
    end

  end

  def destroy
    
    @link.destroy
    flash[flash:success] = "Link was deleted"
    redirect_to category_path(@category)
  end



  # to stop people hacking our site, only allow the following from the form
  def link_params
  	params.require(:link).permit(:name, :description, :url)
  end


 def get_category
 	#becuae we're not in the categories controller we need to fin the ID of the category
 	#using the /categories/ :cateory_id/links/new
 	@category = Category.find(params[:category_id])
end


def get_link
  @link = @category.links.find(params[:id])
end
end
