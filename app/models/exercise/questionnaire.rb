class Exercise::Questionnaire < Exercise

  has_many :options, class_name: 'Exercise::Option', inverse_of: :questionnaire

  validates :statement, presence: true

  def to_s
    statement
  end
end

