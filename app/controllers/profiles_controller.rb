class ProfilesController < InheritedResources::Base
  before_filter :authenticate_teacher!
  respond_to :html, :xml, :json

  skip_before_filter :check_profiles
  load_and_authorize_resource

  def create
    create! { profiles_path }
  end

  def update
    update! { profiles_path }
  end

  def update_tlresults
    update! do |success, failure|
      success.html { redirect_to profile_qualifyingentities_path(resource) }
      failure.html do
        render :edit_tlresults
      end
    end
  end

  def edit_scores
    @quarters = Quarter.for_this_year
    @qualifyingentities = resource.qualifyingentities.where(:quarter_id => params[:quarter_id] || @quarters.map(&:id))
    @qualifyingentity_tlresults = @qualifyingentities.map(&:qualifyingentity_tlresults).flatten.uniq.sort
    @students = resource.classroom ? resource.classroom.students : []
    @students.each do |student|
      @qualifyingentities.each do |qe|
        qe.qualifyingentity_tlresults.each do |qe_tlr|
          score = qe_tlr.scores.find_by_student_id(student.id)
          Score.create(:qualifyingentity_tlresult_id => qe_tlr.id, :student_id => student.id) unless score
        end
      end
    end
  end

  def update_scores
    update! do |success, failure|
      success.html { redirect_to profiles_path}
      failure.html do
        @qualifyingentities = resource.qualifyingentities
        @students = resource.classroom.students
        render :edit_scores
      end
    end
  end

  private

  def collection
    @q ||= end_of_association_chain.accessible_by(current_ability).search(params[:q])
    @q.sorts = "institute_id" if @q.sorts.empty?
    @profiles = @q.result(:distinct => true).page(params[:page])
  end
end
