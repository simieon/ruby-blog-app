class Todo < ApplicationRecord
  validates :text, presence: true

  scope :text_search, -> (search_value) {
    target = "%#{search_value}%"
    where("text LIKE ?", target)
  }

  scope :pagination_todo, -> (end_date){
    today = Date.today
    where("deadline >= ? AND deadline <= ?", today, end_date)
  }

  scope :uncompleted, -> (){
    today = Date.today
    where("deadline <= ?", today)
  }

end
