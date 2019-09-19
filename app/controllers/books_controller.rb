class BooksController < ApplicationController
  before_action :authenticate_user!
  # protect_from_forgery :except => [:create]
	def new
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id

     if @book.save
          flash[:notice] = "The book was successfully created"
          redirect_to book_path(@book)
        else
          @books = Book.all
          flash[:notice] = "error"
          @user = current_user
          render 'index'
       end
    end

    def index
        @books = Book.all
        @book = Book.new
        @users = User.new
        @user = current_user
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
    end

    def edit
          @book = Book.find(params[:id])
          @user = @book.user
      if  @user == current_user
      else
          redirect_to books_path
      end
    end

    def update
         @book = Book.find(params[:id])
         @book.user_id = current_user.id

      if @book.update(book_params)
         flash[:notice] = "the Book was successfully edited"
         redirect_to book_path(@book)
      else
         @books = Book.all
         flash[:notice] = "error"
         render :edit
      end
    end


    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end

private
  def book_params
    params.require(:book).permit(:title, :body, )
  end
  def user_params
    params.require(:user). permit(:id, :name, :introduction, :profile_image)
   end
end
