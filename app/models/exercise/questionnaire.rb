class Exercise::Questionnaire < Exercise

  has_many :options, class_name: 'Exercise::Option', inverse_of: :questionnaire, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
end

