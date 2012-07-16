require 'test_helper'

class SurveyAnswerTest < ActiveSupport::TestCase
  fixtures :survey_answers, :wikis

  def test_new
    survey_answer = SurveyAnswer.new
    assert_equal 1, survey_answer.wiki_id, "Wrong wiki_id"
  end  

end
