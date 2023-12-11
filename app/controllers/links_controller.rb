class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy visits]
  before_action :authenticate_user!

  # GET /links or /links.json
  def index
    @links = current_user.links.page(params[:page]).per(3)
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
    @link = @link.becomes(Link)
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)
    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        @link = @link.becomes(Link)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        @link = @link.becomes(Link)
        format.html { render :edit , status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def visits
    @visits = @link.visits.page(params[:page]).per(24)
    filter_visits
  end

  private

  def set_link
    @link = Link.find_by(id: params[:id])
    if @link && @link.user != current_user
      flash[:alert] = "You are not the owner of this link"
      redirect_to root_path
    elsif @link.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:url, :name, :type, :password, :expiration_date)
  end

  def filter_visits
    @visits = @visits.filter_by_ip(params[:ip]) if params[:ip].present?
    @visits = @visits.filter_by_start_date(params[:start_date]) if params[:start_date].present?
    @visits = @visits.filter_by_end_date(params[:end_date]) if params[:end_date].present?
  end
end
