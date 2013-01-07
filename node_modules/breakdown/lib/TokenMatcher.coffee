
class TokenMatcher

  @match: ( @file, @tokens ) ->

    highestscore = -1
    highestordinal = -1

    for ordinal, tokens of @file.tokens

      if tokens.indexOf( '#' ) > -1 then continue

      score = TokenMatcher.compare tokens, @tokens

      if highestscore < score
        highestscore = score
        highestordinal = Number ordinal

    return highestordinal + 1

  @compare: ( tokens1, tokens2 ) ->

    score = 0
    tokens1.map (t) -> score++ if tokens2.indexOf( t ) > -1
    return score

module.exports = TokenMatcher