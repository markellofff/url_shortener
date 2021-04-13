# links controller
class LinksController < ApplicationController
  before_action :set_link, only: %i[new create]
  def index
    @links = Link.all
  end

  def show
    @link = Link.find_by_slug(params[:slug])
    render 'errors/404', status: 404 if @link.nil?
    @link.update_attribute(:clicked, @link.clicked + 1)
    redirect_to @link.url
  end

  def new; end

  def create
    @link.assign_attributes(link_params)
    @link.save!
    flash[:notice] = 'Url shortened successfully'
    redirect_to links_path
  rescue StandardError => e
    Rails.logger.error e.backtrace.join("\n")
    flash[:alert]  = e.message
    render 'new'
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def set_link
    @link = Link.new
  end
end