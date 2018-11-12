class Ranking::District < Ranking
  belongs_to :district, class_name: '::District', inverse_of: :ranking_districts

  def to_s
    position
  end
end