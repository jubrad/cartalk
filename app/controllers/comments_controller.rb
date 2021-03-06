class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_plate

  def index
    @comments = Comment.all
  end

  def show
  end


  def new
    @comment = Comment.new
  end


  def edit
  end


  def create
    @comment = @plate.comments.create(params[:comment].permit(:content))
    # @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to plate_path(@plate)
    else
      render 'new'
    end
  end


  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to plates_url(@plate), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_plate
      @plate = Plate.find(params[:plate_id])
    end
end
