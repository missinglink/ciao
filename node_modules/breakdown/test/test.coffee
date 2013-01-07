require '../bootstrap'

test = ->
  people =
    john:
      first_name: 'john'
      last_name: 'doe'
    mary:
      first_name: 'mary'
      last_name: 'jane'

  # require './invalid'
  
  # throw new Error 'palevioletred'
  console.log("Welcome", people[p].first_name, people[p].last_name, "!!!") for p in ['john', 'mary', 'josh']

delegate = -> test()

process.nextTick delegate
