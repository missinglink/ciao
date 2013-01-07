
module.exports = (trace) ->
  
  foo = trace.error.stack.split("\n")[0]

  console.error "\n\x1b[0;33m    ( ("
  console.error "     ) )"
  console.error "   ________"
  console.error "  |        |]"
  console.error "   \\      /"
  console.error "    `----'  ❛●•・\x1b[0m"
  console.error " \x1b[1;41;37m Coffee-Trace \x1b[0m \x1b[1;37m #{foo} \x1b[0m"
  console.error()