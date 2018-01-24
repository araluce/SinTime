class Exercise::Feeding < Exercise

  scope :food, -> { where(feeding_type: 'Comida') }
  scope :water, -> { where(feeding_type: 'Agua') }

  enum feeding_type: %w(Comida Agua), _prefix: true

  def is_food?
    feeding_type == 'Comida'
  end

  def is_water?
    feeding_type == 'Agua'
  end
end
