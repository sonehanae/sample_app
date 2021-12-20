class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(content: params[:content])
    if @post.save
      #redirect_toだからindexアクションを経由してからビューを表示している(ような気がする)
      flash[:notice] = "投稿を作成しました(^^)b"
      redirect_to("/posts/index")
    else
       #renderを使うとnewアクションを経由しないでビューを表示できる(たぶん)
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end 

  def update
    @post = Post.find_by(id:params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to("/posts/index")
      flash[:notice] = "投稿を編集しました(^^)b"
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id:params[:id]) 
    @post.destroy
    flash[:notice] = "投稿を削除しました(^^)ﾉｼ"
    redirect_to("/posts/index")
  end

end