class HomeController < ApplicationController
  before_action { landing_banner(true) }
  before_action :filter_data, only: [:index, :fetch_listings]

  def index
    @listings = Listing.fetch_by_filters(params).paginate(:page => params[:page], :per_page => Listing::PER_PAGE)
  end

  def test
    render layout: "test"
  end

  private

  def filter_data
    @categories = Category.all
    @designers = Designer.all
    @tops = Size.tops
    @bottoms = Size.bottoms
    @shoes = Size.shoes
    @accessories = Size.accessories
    @condtions = Listing::CONDITIONS
  end
end
