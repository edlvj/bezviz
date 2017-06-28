class City < ApplicationRecord
  belongs_to :country
  has_many :topic
  has_one :rating
  
  after_save :add_geo
  
  mount_uploader :image, CityImageUploader
  validates :title, presence: true
  
  private
  
  def add_geo
    cord = GeocordService.new(self.title_eng).getCord 
    self.update_attributes(lat: cord.lat, long: cord.long) if !cord.nil?
  end
end
