class BooksController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @book = Book.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all.order(id: :asc)
      render :index
    end
  end

  def index
    @books = Book.all.order(id: :asc)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
     redirect_to book_path(@book)
    else
      render :edit
    end
  end



  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private
   def book_params
     params.require(:book).permit(:title, :body)
   end

end
