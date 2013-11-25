# encoding: utf-8
# Contains all the methods for finding and replacing wiki words
module WikiWords
  # In order of appearance: Latin, greek, cyrillian, armenian
  I18N_HIGHER_CASE_LETTERS =
    "À�?ÂÃÄÅĀĄĂÆÇĆČĈĊĎ�?ÈÉÊËĒĘĚĔĖĜĞĠĢĤĦÌ�?Î�?ĪĨĬĮİĲĴĶ�?ĽĹĻĿÑŃŇŅŊÒÓÔÕÖØŌ�?ŎŒŔŘŖŚŠŞŜȘŤŢŦȚÙÚÛÜŪŮŰŬŨŲŴ�?ŶŸŹŽŻ" + 
    "ΑΒΓΔΕΖΗΘΙΚΛΜ�?ΞΟΠΡΣΤΥΦΧΨΩ" + 
    "ΆΈΉΊΌΎ�?ѠѢѤѦѨѪѬѮѰѲѴѶѸѺѼѾҀҊҌҎ�?ҒҔҖҘҚҜҞҠҢҤҦҨҪҬҮҰҲҴҶҸҺҼҾ�?ӃӅӇӉӋ�?�?ӒӔӖӘӚӜӞӠӢӤӦӨӪӬӮӰӲӴӸЖ" +
    "ԱԲԳԴԵԶԷԸԹԺԻԼԽԾԿՀ�?ՂՃՄՅՆՇՈՉՊՋՌ�?�?�?ՑՒՓՔՕՖ" unless const_defined? "I18N_HIGHER_CASE_LETTERS"

  I18N_LOWER_CASE_LETTERS =
    "àáâãäå�?ąăæçć�?ĉċ�?đèéêëēęěĕėƒ�?ğġģĥħìíîïīĩĭįıĳĵķĸłľĺļŀñńňņŉŋòóôõöø�?ő�?œŕřŗśšş�?șťţŧțùúûüūůűŭũųŵýÿŷžżźÞþßſ�?ð" +
    "άέήίΰαβγδεζηθικλμνξοπ�?ςστυφχψωϊϋό�?ώ�?" +
    "абвгдежзийклмнопр�?туфхцчшщъыь�?ю�?�?ёђѓєѕіїјљћќ�?ўџѡѣѥѧѩѫѭѯѱѳѵѷѹѻѽѿ�?ҋ�?�?ґғҕҗҙқ�?ҟҡңҥҧҩҫҭүұҳҵҷҹһҽҿӀӂӄӆӈӊӌӎӑӓӕӗәӛ�?ӟӡӣӥӧөӫӭӯӱӳӵӹ" +
    "աբգդեզէըթժիլխծկհձղճմյնշոչպջռսվտր�?ւփքօֆև" unless const_defined? "I18N_LOWER_CASE_LETTERS" 

  WIKI_WORD_PATTERN = '[A-Z' + I18N_HIGHER_CASE_LETTERS + '][a-z' + 
    I18N_LOWER_CASE_LETTERS + ']+[A-Z' + 
    I18N_HIGHER_CASE_LETTERS + ']\w+' unless const_defined? "WIKI_WORD_PATTERN" 
    
  unless const_defined? "CAMEL_CASED_WORD_BORDER"   
    CAMEL_CASED_WORD_BORDER = /([a-z#{I18N_LOWER_CASE_LETTERS}])([A-Z#{I18N_HIGHER_CASE_LETTERS}])/u 
  end


  def self.separate(wiki_word)
    wiki_word.gsub(CAMEL_CASED_WORD_BORDER, '\1 \2')
  end

end
