class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,	 :only => :destroy
	
	def index
		@users = User.paginate(:page => params[:page])
		@title = "All users"
	end
 
	def show
    @user = User.find(params[:id])
		@title = @user.name
  end
  
  def new
    @user = User.new
		@title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
			@user.password.clear
			@user.password_confirmation.clear
		end
  end
	
	def edit
		@title = "Edit user"
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def destroy
		@user = User.find(params[:id])
		if @user.admin?
			flash[:error] = "Admin cannot be destroyed."
			redirect_to users_path
		else
			@user.destroy
			flash[:success] = "User destroyed."
			redirect_to users_path
		end
	end
	
	private
	
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end