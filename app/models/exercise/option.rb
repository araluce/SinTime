class Exercise::Option < ApplicationRecord
  belongs_to :questionnaire, class_name: 'Exercise::Questionnaire', inverse_of: :options

  has_many :user_questionnaire_options, class_name: 'UserQuestionnaireOption', inverse_of: :option, dependent: :destroy
  has_many :user_questionnaires, class_name: 'UserQuestionnaire', through: :user_questionnaire_options, inverse_of: :options

  validates :option, presence: true

  def to_s
    option
  end
end
