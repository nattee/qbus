class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy, :publish, :delete_main_attachment, :delete_other_attachments]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  def lists
    @publishes = Announcement.publishes
  end

  def publish
  end

  # POST /announcements
  # POST /announcements.json
  def create
    puts announcement_params
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_main_attachment
    @announcement.main_attachment.purge
    redirect_to @announcement, notice: "#{t(:main_attachment, scope: 'activerecord.attributes.announcement')} removed"
  end

  def delete_other_attachments
    @announcement.other_attachments.find_by_id(params[:attachment_id])&.purge
    redirect_to @announcement, notice: "#{t(:other_attachments, scope: 'activerecord.attributes.announcement')} removed"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :description, :published, :user_id, :main_attachment, other_attachments: [])
    end
end
