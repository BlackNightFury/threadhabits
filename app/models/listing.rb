# == Schema Information
#
# Table name: listings
#
#  id                         :integer          not null, primary key
#  name                       :string
#  description                :string
#  category_id                :integer
#  person_id                  :integer
#  price                      :float
#  condition                  :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  slug                       :string
#  company_id                 :integer
#  size_id                    :integer
#  product_type_id            :integer
#  display_image_file_name    :string
#  display_image_content_type :string
#  display_image_file_size    :integer
#  display_image_updated_at   :datetime
#

class Listing < ApplicationRecord
  belongs_to :category
  belongs_to :person
  belongs_to :size
  belongs_to :product_type
  belongs_to :company, class_name: "Designer", foreign_key: :company_id

  has_many :uploads, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy

  has_one :address, as: :owner, dependent: :destroy
  accepts_nested_attributes_for :address

  has_attached_file :display_image, styles: { medium: "400x500#", large: "1200x1200>", banner: "950x505>" }, :default_url => "/assets/profile-icon.png"
  validates_attachment_content_type :display_image, content_type: /\Aimage\/.*\Z/

  include Utilities
  include Common

  validates_presence_of :description, :size
  validates_uniqueness_of :slug

  %w(tops outerwear bottoms shoes accessories).each do |product|
    scope product.to_sym, -> { joins(:size => :product_type).where("lower(product_types.name) = ?", product) }
  end

  CONDITIONS = [
    "1/10", "2/10", "3/10", "4/10", "5/10", "6/10", "7/10", "8/10", "9/10", "Deadstock"
  ]

  PER_PAGE = 30

  def upload_photos(files = [])

    if self.display_image.blank?
      self.display_image = files.first
      save!
    end
    files.each{|file| uploads.create(image: file) }
  end

  def has_address?
    address.present?
  end

  def valid_attribute?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end

  def as_json(options)
    if options.blank?
      hash = super()
      hash[:category_name] = self.category.try(:name).to_s
      hash[:person_first_name] = self.person.try(:first_name).to_s
      hash[:person_last_name] = self.person.try(:last_name).to_s
      hash[:price_display] = ActionController::Base.helpers.number_to_currency self.price.to_i, precision: 0
      hash[:last_updated_at] = self.updated_at.to_i
      hash[:company_name] = self.company.try(:name).to_s
      hash[:size_name] = self.size.name.split('/').first rescue ''

      hash[:display_image_url] = self.display_image(:medium)
      hash[:upload_urls] = []
      self.uploads.each do |upload|
        hash[:upload_urls] << upload.image.url(:medium)
      end
      return hash
    else 
      return super(options)
    end
    
  end

  def self.fetch_by_filters(filters)
    listings = all.includes(:size, :company).order("listings.created_at desc")
    conditions = []

    if filters[:category_ids]
      conditions << "category_id in (:categories)"
    end

    if (filters.keys & ["lower_price", "upper_price"]).length == 2
      conditions << "price >= #{filters[:lower_price]} AND price <= #{filters[:upper_price]}"
    end

    if filters[:product_type].present?
      listings = listings.send(filters[:product_type])
    end

    if filters[:company_ids]
      conditions << "company_id in (:companies)"
    end


    if filters[:size_names].present?
      listings = listings.joins(:size) unless filters[:product_type].present?
      conditions << "sizes.name in (:size_names)"
    end

    if filters[:location].present?
      listings = listings.joins(:address)
      conditions << "addresses.latitude in (:latitude) and addresses.longitude in (:longitude)"
    end

    if filters[:conditions]
      conditions << "condition in (:conditions})"
    end

    if filters[:q].present?
      listings = listings.joins(:company)
      conditions << "(listings.name iLike (:query) OR description iLike (:query) OR designers.name iLike (:query))"
    end

    listings.where(conditions.join(" AND "), {
        size_names: filters[:size_names].try(:uniq), companies: filters[:company_ids],
        categories: filters[:category_ids], condition: filters[:conditions],
        latitude: filters[:latitude], longitude: filters[:longitude],
        query: "%#{filters[:q]}%"
      }
    )
  end

  def belongs_to_person?(person)
    person_id == person.id
  end
end
