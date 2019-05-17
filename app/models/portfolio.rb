class Portfolio < ApplicationRecord
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                reject_if: lambda { |attrs| attrs['name'].blank? }

  include Placeholder
  validates_presence_of :title, :body, :main_image, :thumb_image

  # Custom scope type 1. e.g. Portfolio.angular from controller returns this.
  def self.angular
    where(subtitle: 'Angular')
  end

  def self.order_by_position
    order("position ASC")
  end

  # Custom scope type 2. e.g. Portfolio.ruby_on_rails from controller returns this.
  scope :ruby_on_rails, -> { where(susbtitle: 'Ruby on Rails') }

  after_initialize :set_defaults

  def set_defaults
    self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
    self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
  end
end
