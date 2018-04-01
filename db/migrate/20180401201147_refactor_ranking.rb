class RefactorRanking < ActiveRecord::Migration[5.1]
  def change
    add_column :rankings, :classification, :boolean, after: :midchronic, default: false

    Ranking.update_all(classification: true)
  end
end
