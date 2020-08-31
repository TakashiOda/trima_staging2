class HomeController < ApplicationController
  def index
    @activities = Activity.all.limit(4)
  end

  def about_page_for_user
  end

end
