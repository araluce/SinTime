class Exercise::Option < ApplicationRecord
  belongs_to :questionnaire, class_name: 'Exercise::Questionnaire', inverse_of: :options

  validates :option, presence: true

  def to_s
    option
  end
end
