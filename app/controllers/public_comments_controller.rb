class PublicCommentsController < ApplicationController
  before_action :set_public_comment, only: [:show, :edit, :update, :destroy]

  # GET /public_comments
  # GET /public_comments.json
  def index
    @public_comments = PublicComment.all
  end

  # GET /public_comments/1
  # GET /public_comments/1.json
  def show
  end

  def application
    @public_comments = PublicComment.by_application(params[:application_id])
  end

  # GET /public_comments/new
  def new
    @public_comment = PublicComment.new
  end

  def add_comment
    @public_comment = PublicComment.new
  end

  def add_comment_post
    puts public_comment_params
    @public_comment = PublicComment.new(public_comment_params)

    if @public_comment.save
      redirect_to root_path, notice: 'ข้อคิดเห็นของท่านไ้ดรับการบันทึกเรียบร้อยแล้ว'
    else
      render :add_comment
    end
  end


  # POST /public_comments
  # POST /public_comments.json
  def create
    puts public_comment_params
    @public_comment = PublicComment.new(public_comment_params)

    respond_to do |format|
      if @public_comment.save
        format.html { redirect_to @public_comment, notice: 'Public comment was successfully created.' }
        format.json { render :show, status: :created, location: @public_comment }
      else
        format.html { render :new }
        format.json { render json: @public_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_comments/1
  # PATCH/PUT /public_comments/1.json
  def update
    respond_to do |format|
      if @public_comment.update(public_comment_params)
        format.html { redirect_to @public_comment, notice: 'Public comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @public_comment }
      else
        format.html { render :edit }
        format.json { render json: @public_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_comments/1
  # DELETE /public_comments/1.json
  def destroy
    @public_comment.destroy
    respond_to do |format|
      format.html { redirect_to public_comments_url, notice: 'Public comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_comment
      @public_comment = PublicComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_comment_params
      params.require(:public_comment).permit(:route_no, :route_id, :car_plate, :car_id, :licensee_name, :licensee_id, :comment, :commenter_name, :commenter_contact, :commenter_address)
    end
end
