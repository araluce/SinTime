class CreateUserQuestionnaireOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_questionnaire_options do |t|
      t.belongs_to :user_questionnaire
      t.belongs_to :option
      t.timestamps
    end
  end
end
