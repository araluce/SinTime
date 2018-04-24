class CreateUserQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    create_table :user_questionnaires do |t|
      t.belongs_to :user
      t.belongs_to :questionnaire
      t.timestamps
    end
  end
end
