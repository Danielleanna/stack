class LinksController < ApplicationController

	#Before EVERYTHING in here, find the category
	before_action :get_category


  def new
 	@link = @category.links.new
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
    #I want to find the linnk within the category
    @link = @category.links.find(params [:id])
  end



  def update
    @link =@category.links.find(params [:id])

    if @link.update(link_params)
      flash[:success] = "Link as updated"
      redirect_to category_path(@category)
    else
      render :edit
    end
    
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

end
