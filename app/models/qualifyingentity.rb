class Qualifyingentity < ActiveRecord::Base
  attr_accessible :name, :profile_id, :qualifyingentity_tlresults_attributes
  
  #Mediante profile se determina la asignatura para la que se están creando las entidades calificables
  belongs_to :profile
  #Relación con los tlresult y sus porcentajes
  has_many :qualifyingentity_tlresults
  has_many :tlresults, :through => :qualifyingentity_tlresults

  has_many :scores
  #FIXME: queda pendiente determinar las relaciones con los alumnos
  belongs_to :classroom
   #FIXME: revisar más adelante
  has_many :qualifyingentity_criterions
  has_many :criterions, :through => :qualifyingentity_criterions
  has_many :students, :through => :scores
  has_and_belongs_to_many :contentblocks

  #accepts_nested_attributes_for :qualifyingentity_criterions, :reject_if => :all_blank, :allow_destroy => true 
  accepts_nested_attributes_for :qualifyingentity_tlresults, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :scores

  #  before_destroy :can_be_destroyed?
  after_save :create_qualifyingentity_tlresults

  validates :name, :presence => true
  validates :profile_id, :presence => true
  #validates :score_ids, :presence => true

  scope :for_profile, lambda {|profile|
    where("profile_id = ?", profile.id) if profile
  }

  #  def can_be_destroyed?
  #    true unless self.classroom.empty?
  #  end
  
  def teacher
    unless self.classroom.nil?
      self.classroom.teacher
    end
  end

  def create_qualifyingentity_tlresults
    self.contentblocks.each do |cb|
      self.qualifyingentity_tlresults.build(:percentage => 0, :tlresult_id => cb.tlresult.id) unless tlresult_ids.include?(tlresult.id)
      self.save
    end
  end
end
