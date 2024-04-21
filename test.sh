# Find all .lean files in test and subdirectories, replace .lean with .run
TESTS := $(shell find test -type f -name '*.lean' | sed 's/\.lean$$/.run/')

$(TESTS)