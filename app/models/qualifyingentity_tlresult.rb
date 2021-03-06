class QualifyingentityTlresult < ActiveRecord::Base
  attr_accessible :qualifyingentity_id, :tlresult_id, :percentage, :scores_attributes
  belongs_to :qualifyingentity
  belongs_to :tlresult

  has_many :scores, :inverse_of => :qualifyingentity_tlresult, :dependent => :destroy
  has_many :students, :through => :scores

  delegate :sortable_item, :to => :tlresult, :prefix => false

  validates :tlresult_id, :presence => true
  validates_uniqueness_of :tlresult_id, :scope => :qualifyingentity_id
  validates :percentage, :numericality => {:less_than_or_equal_to => 100, :greater_than => 0}, :allow_nil => true
  #validates_associated :scores

  # FIXME Es necesario si hago el fields_for desde profile
  accepts_nested_attributes_for :scores, :allow_destroy => true

  after_save :update_average_scores

  def update_average_scores
    if percentage_changed?
      scores.each {|score| score.set_average_score }
    end
  end
end
