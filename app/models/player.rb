class Player < ActiveRecord::Base
  attr_accessor :weapon

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_prescence_of :user_id

  belongs_to :user
end