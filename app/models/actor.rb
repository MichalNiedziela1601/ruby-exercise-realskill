class Actor < ActiveRecord::Base
  has_and_belongs_to_many :movies
  validates_presence_of :name
  validates_format_of :date_of_birth, :with => /\A(\d{4})\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])\Z/

  validates_presence_of :rate, inclusion: { in: ("0.0".."10.0"), message: "should be in range from 0.0 to 10.0"}
  validates_presence_of :votes_count, numericality: {greater_than_or_equal_to: 0}

  before_validation :default_rate, :default_count, on: :create
  def default_rate
    if rate.blank?
      self.rate = "0.0"
    end

  end

  def default_count
    if votes_count.blank?
      self.votes_count = 0
    end
  end
end
