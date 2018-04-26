module QuestionnaireHelper

  def questionnaire_user_questionnaires_pass(questionnaire)
    results = []
    questionnaire.user_questionnaires.each {|user_questionnaire| results << user_questionnaire if user_questionnaire.all_right?}
    results
  end

  def questionnaire_user_questionnaires_not_pass(questionnaire)
    results = []
    questionnaire.user_questionnaires.each {|user_questionnaire| results << user_questionnaire unless user_questionnaire.all_right?}
    results
  end

  def questionnaire_users_pass(questionnaire)
    questionnaire_user_questionnaires_pass(questionnaire).map {|user_questionnaires| user_questionnaires.user}
  end
end