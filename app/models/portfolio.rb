class Portfolio < ApplicationRecord
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                allow_destroy: true,
                                reject_if: lambda { |attrs| attrs['name'].blank? }

  validates_presence_of :title, :body

  mount_uploader :thumb_image, PortfolioUploader
  mount_uploader :main_image, PortfolioUploader

  # Custom scope type 1. e.g. Portfolio.angular from controller returns this.
  def self.angular
    where(subtitle: 'Angular')
  end

  def self.order_by_position
    order("position ASC")
  end

  # Custom scope type 2. e.g. Portfolio.ruby_on_rails from controller returns this.
  scope :ruby_on_rails, -> { where(susbtitle: 'Ruby on Rails') }
end
