class QualifyingentitiesController < InheritedResources::Base
  before_filter :authenticate_teacher!  
  respond_to :html, :xml, :json

  private
  def collection
    @q ||= Qualifyingentity.accessible_by(current_ability).search(params[:q])
    @q.sorts = "name asc" if @q.sorts.empty?
    @qualifyingentities||= @q.result(:distintct => true).page(params[:page])
  end
end