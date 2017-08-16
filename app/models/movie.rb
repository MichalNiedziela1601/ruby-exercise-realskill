class Movie < ActiveRecord::Base
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :genres
  validates_presence_of :title, :description
  validates_presence_of :year, inclusion: { in: 1900..(Date.today.year + 3)}

end
