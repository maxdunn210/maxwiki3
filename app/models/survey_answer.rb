class SurveyAnswer < MaxWikiActiveRecord
  belongs_to :wiki; default_scope method :wiki_filter
  belongs_to :survey_response
  belongs_to :survey
  has_one :survey_question
end
