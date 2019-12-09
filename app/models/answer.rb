class Answer < ApplicationRecord
  belongs_to :user

  scope :correct, ->() { where(correct: true) }
  scope :accuracy, ->() { ((average(:correct) || 0) * 100).to_i }#{ count != 0? correct.count * 100 / count : 0 }

  scope :within_week, ->(from) { where(created_at: from.beginning_of_week..from.beginning_of_week.next_week) }
  scope :between_dates, ->(from, to) { where(created_at: from.beginning_of_day..to.beginning_of_day.next_day) }
  scope :avg, ->() { group(:user_id).average(:correct) }

  def self.top_within_week(from)
    prev = within_week(from.prev_week).avg
    within_week(from).avg
      .map {|k, v| [k, v, v - prev[k]]}
      .sort {|a, b| b[1] <=> a[1]}
      .slice(0, 100)
      .map {|a| a[1], a[2] = (a[1]*100).to_i, (a[2]*100).to_i; a }
  end
end
