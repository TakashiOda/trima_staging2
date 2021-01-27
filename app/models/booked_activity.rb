class BookedActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :cart

  has_many :bookedactivity_members, dependent: :destroy
  has_many :project_members, through: :bookedactivity_members
  accepts_nested_attributes_for :bookedactivity_members


  # 予約が人数に対して十分な在庫を持っているかチェック
  def isBookable
    activity = Activity.find(self.activity_id)
    # binding.pry
    # course = activity.activity_courses.find_by(start_time: self.activity_start_time)
    course = ActivityCourse.find(self.course_id)
    stock = ActivityStock.find(self.stock_id)
    members_num = self.project_members.size
    stock.stock = stock.stock - members_num
    if stock.stock >= 0
      return true
    else
      return false
    end
  end

  # 予約に決済されたことを渡す
  def hasPaid
    self.is_paid = true
    self.purchase_date = Time.zone.now.to_datetime
    self.save!
  end

  # 体験在庫から予約分の在庫を差し引く
  def reduceStock
    activity = Activity.find(self.activity_id)
    # binding.pry
    course = ActivityCourse.find(self.course_id)
    stock = ActivityStock.find(self.stock_id)
    # course = activity.activity_courses.find_by(start_time: self.activity_start_time)
    # stock = course.activity_stocks.find_by(date: self.activity_date)
    members_num = self.total_participants
    # members_num = self.project_members.size
    stock.stock = stock.stock - members_num
    stock.save!
  end
end
