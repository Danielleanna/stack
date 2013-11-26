class CategoriesController < ApplicationController


	#I want to run get_category before the show, edit, update, destroy. 
	#and I dont wan't to keep having to repeat 
	#the same code over and over
	#we can use before_action to do things before any method (a.k.a action)

	before_action :get_category, only: [:show, :edit, :update, :destroy]

	#step number 2 is to add in a index page
	#we want to define the index of our controller
	def index
		#this is where all of our code for the index page lives

		#the quotes mean a string
		#a string is some data
		@username = "danielle"

		# age is only a number
		@age = 28

		# to do a list, we use an array
		#@categories = ["Design", "Rails", "Javascript", "Site tools", "Data vis"]

		#now lets talk to the model
		@categories = Category.all.order("rank asc")


	end
#individual page for the category




def show
	# category is now in get_category method that runs before this action
end




#the new form for a category
def new
	@category = Category.new

end




# actually add the category using the data the form has in it
def create
	@category = Category.new(category_params)
	
	if @category.save
		
		flash[:success] = "Category added"


		#go back to the homepage
		redirect_to root_path

	else
		
		#if the category does NOT save I want to show the form again but
		#some errors
		#we've already got the view that we want to show to the user
		#this is the new.html.erb
		render "new"


	end
end




#get a form to edit this category
def edit
	# category is now in get_category method that runs before this action
end




#actually update the row in the database
def update
	# category is now in get_category method that runs before this action

	if @category.update(category_params)

		flash[:success] = "Category updated"

		#go back to the homepage
		redirect_to root_path
		
	else
		# show the edit form if it doesn't update
		render "edit"
		
	end
end




#actually delete the category in the database
def destroy

	#destroy that row
	@category.destroy

	#tell the user they've deleted this category
	flash[:success] = "Category deleted"

	#go back to the homepage
	redirect_to root_path
end





#to not repeat ourselves lets create a brand new method to simplify things I can call a method whatever I like
def get_category
	@category = Category.find(params[:id])
end





# whitelist all of the form data
#make sure we are scure from hackerz
def category_params
	params.require(:category).permit(:name, :rank)

end




end
