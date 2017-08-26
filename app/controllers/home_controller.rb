class HomeController < ApplicationController
  before_action only: [ :landing ] { landing_banner(true) }
  before_action :filter_data, only: [ :inventory ]
  before_action :authenticate_person!, only: [ :verify_unread_message ]
  # before_action :authenticate_person!, except: [:beta_landing_page,:about_us]
  layout "beta", :only => [ :beta_landing_page]
  def landing
    @landing_banners = [
        {
          path: "javascript:void(0);",
          url: "banner-1.jpg",
          text: "Buying and Selling Menswear"
        },
        {
          path: inventory_path,
          url: "banner-2.jpg",
          text: "Browse"
        },
        {
          path: "javascript:void(0);",
          url: "banner-3.jpg",
          text: "Designers"
        },
        {
          path: new_listing_path,
          url: "banner-4.jpg",
          text: "Sell"
        }
    ]
  end

  def beta_landing_page
    redirect_to :inventory if current_person
  end

  def inventory
    @banner = params[:banner] || true

    if @p[:filters].present?
      @banner = false
      @p[:filters].merge!(q: params[:q]) if params[:q].present?
    end

    @listings = Listing.fetch_by_filters(@p[:filters]).paginate(:page => params[:page], :per_page => Listing::PER_PAGE)

    sleep 2 if request.xhr?

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @listings }
    end
  end

  def designers
  end

  def verify_unread_message
    message = current_person.received_messages.order("created_at desc").first
    read = true
    if message.present?
      read = message.has_read?
    end
    render json: { status: 200, unread: read }
  end

  def about_us
  end

  def contact_us
  end

  private

  def filter_data
    @designers   =  Rails.cache.fetch("designers", expires_in: 1.hour) do
                      Designer.all
                    end
    @tops        =  Rails.cache.fetch("tops", expires_in: 1.hour) do
                      Size.tops
                    end
    @bottoms     =  Rails.cache.fetch("bottoms", expires_in: 1.hour) do
                      Size.bottoms
                    end
    @shoes       =  Rails.cache.fetch("shoes", expires_in: 1.hour) do
                      Size.shoes
                    end
    @accessories =  Rails.cache.fetch("accessories", expires_in: 1.hour) do
                      Size.accessories
                    end
    @conditions = Listing::CONDITIONS
  end
end
