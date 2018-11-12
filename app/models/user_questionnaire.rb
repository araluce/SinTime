class UserQuestionnaire < ApplicationRecord
  belongs_to :user, class_name: 'User', inverse_of: :user_questionnaires
  belongs_to :questionnaire, class_name: 'Exercise::Questionnaire', inverse_of: :user_questionnaires

  has_many :user_questionnaire_options, class_name: 'UserQuestionnaireOption', inverse_of: :user_questionnaire
  has_many :options, class_name: 'Exercise::Option', through: :user_questionnaire_options, inverse_of: :user_questionnaires

  validates :user_id, uniqueness: { scope: :questionnaire_id }

  def questionnaire_right_options
    questionnaire.options.where(right: true)
  end

  def my_right_options
    options.where(right: true)
  end

  def all_right?
    questionnaire_right_options == my_right_options
  end
end
