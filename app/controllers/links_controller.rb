class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links
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
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
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
        format.html { render :edit, status: :unprocessable_entity }
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

  def access
    @slug = params[:slug]
    link = Link.find_by(slug: @slug)
    if link.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      type = link.link_category
      if type == "regular" || (type == "ephemeral" && link.visits.count == 0) || (type == "temporal" && link.in_time?)
        link.visits.create(ip: request.remote_ip, date: Time.now)
        @url = link.url
        render 'links/redirection'
      elsif type == "exclusive"
        render 'links/insert_password'
      else
        render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    end
  end

  def validate_password
    @slug = params[:slug]
    password = params[:password]
    link = Link.find_by(slug: @slug)

    if !link.nil? && link.authenticated?(password)
      link.visits.create(ip: request.remote_ip, date: Time.now)
      redirect_to link.url, allow_other_host: true
    else
      redirect_to access_path(slug: @slug), notice: "Wrong password"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :link_category, :password, :expiration_date)
    end
end
