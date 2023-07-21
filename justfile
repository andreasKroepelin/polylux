# Local Variables:
# mode: makefile
# End:
test_dir := "./tests"

test:
  ./scripts/test test

update-test:
  ./scripts/test update
