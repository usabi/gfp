class TrainercyclesController < InheritedResources::Base
  before_filter :authenticate_teacher!
  skip_before_filter :check_profiles, :if => :update_matter

  respond_to :html, :xml, :json, :js
  def update_matter
    respond_to do |format|
      format.json { render :json => resource.matters.map {|matter| [matter.name, matter.id] }.to_json }
    end
  end
end
