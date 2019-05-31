# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  answer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  validate :respondent_already_answered?, :respondent_is_poll_author?

  belongs_to :respondent,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :answer_choice,
  primary_key: :id,
  foreign_key: :answer_id,
  class_name: :AnswerChoice

  has_one :question,
  through: :answer_choice,
  source: :question

  def sibling_responses
    self.question.responses.where.not('responses.id = (?)', self.id)
  end

  def respondent_already_answered?
    sibs = self.sibling_responses
    sibs.each do |response_inst|
      return true if self.user_id == response_inst.user_id
    end
    false
  end

  def respondent_is_poll_author?
    return true if self.answer_choice.question.poll.user_id == self.user_id
    false
  end

end
