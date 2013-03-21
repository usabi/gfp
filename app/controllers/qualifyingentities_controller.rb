class QualifyingentitiesController < InheritedResources::Base
  before_filter :authenticate_teacher!  
  respond_to :html, :xml, :json
  def create
    @qualifyingentity = Qualifyingentity.new(params[:qualifyingentity])
    @qualifyingentity.profile = current_teacher.current_profile
    create!
  end

  private
  def collection
    @q ||= Qualifyingentity.accessible_by(current_ability).for_profile(current_teacher.current_profile).search(params[:q])
    @q.sorts = "name asc" if @q.sorts.empty?
    @qualifyingentities||= @q.result(:distintct => true).page(params[:page])
  end
end
