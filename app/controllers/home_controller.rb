class HomeController < ApplicationController
  def index
    @top_activity = Activity.find(20)
    @activities = Activity.all.limit(6)
    @categories = ActivityCategory.all.limit(15)
  end

  def about_page_for_user
  end

end
