class UserQuestionnaireOption < ApplicationRecord
  belongs_to :user_questionnaire, class_name: 'UserQuestionnaire', inverse_of: :user_questionnaire_options
  belongs_to :option, class_name: 'Option', inverse_of: :user_questionnaire_options

  def is_right?
    option.right
  end
end
