NAME
  
      rego

SYNOPSIS
  
      run arbitrary commands easily when files change

PARAMETERS
  --help, -h 

EXAMPLES
  
      # say hai whenever the file foo.txt changes
      #
        ~> rego echo hai -- foo.txt
  
      # say hai whenever any file (recursively) in bar changes 
      #
        ~> rego echo hai -- ./bar/ 
  
      # echo *the file that changed* when any file (recursively) in bar changes 
      #
        ~> rego echo "@ was changed" -- ./bar/ 
  
      # run a specific test whenever anything in lib, test, app, or config changes
      #
        ~> rego ruby -Itest ./test/units/foo_test.rb --name teh_test -- {lib,test,app,config}
  
      # run a specific test whenever it, or your app, has changed
      #
        ~> rego ruby -Itest @ -- ./test

