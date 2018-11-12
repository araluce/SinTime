class Exercise::Questionnaire < Exercise

  has_many :options, class_name: 'Exercise::Option', inverse_of: :questionnaire, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true

  has_many :user_questionnaires, class_name: 'UserQuestionnaire', inverse_of: :questionnaire, dependent: :destroy
  has_many :users, class_name: 'User', through: :user_questionnaires, inverse_of: :questionnaires
  accepts_nested_attributes_for :user_questionnaires, reject_if: :all_blank, allow_destroy: true

  def type_to_s
    'Questionnaire'
  end
end

