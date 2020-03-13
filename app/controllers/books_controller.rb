class BooksController < ApplicationController
	before_action :ensure_correct_user, only: [:edit]

	def ensure_correct_user
		book = Book.find(params[:id])
		if current_user.id != book.user_id
			redirect_to current_path
		end
	end
	
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book)
			flash[:notice] = "You have creatad book successfully."
		else
			@books = Book.all
			@user = User.find(current_user.id)
			render "books/index"
		end
	end

	def index
		@books = Book.all
		@user = User.find(current_user.id)
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
		@newbook = Book.new
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book)
			flash[:notice] = "You have updated book successfully."
		else
			render "books/edit"
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private

	def book_params
		params.require(:book).permit(:title, :body)
	end
end
