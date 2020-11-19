class StaticPagesController < ApplicationController

  def about_for_user
  end

  def about_for_supplier
    @this_page_is_for = 'supplier'
  end

  def privacy_policy_jp
  end

  def privacy_policy_en
  end

  def term_of_service_jp
  end

  def term_of_service_for_supplier
    @this_page_is_for = 'supplier'
  end

  def term_of_service_en
  end

  def cansel_policy_jp
  end

  def cansel_policy_en
  end
end
