# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  validates :body, presence: true

  belongs_to :poll,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: :Poll

  has_many :answer_choices,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: :AnswerChoice

  has_many :responses,
  through: :answer_choices,
  source: :responses

  def results
    count = Hash.new(0)
    self.answer_choices.each do |answerChoice_inst|
      count[answerChoice_inst.body] = answerChoice_inst.responses.count
    end
    count

    # count = Hash.new(0)
    # self.responses.each do |response_inst|
    #   count[response_inst.answer_id] += 1
    # end
    # count
  end

  def better_results
    count = Hash.new(0)
    answer_choices = self.answer_choices.includes(:responses)
    answer_choices.each do |answer_choice_inst|
      count[answer_choice_inst.body] = answer_choice_inst.responses.length
    end
    count
  end

  def best_results
    count = Hash.new(0)
    answer_choices_with_responses = self.answer_choices
    .select('answer_choices.*, COUNT(*) AS responses_count')
    .joins(:responses)
    .group('answer_choices.id')
    answer_choices_with_responses.each do |acwr|
      count[acwr.body] = acwr.responses_count
    end
    count
  end

end
