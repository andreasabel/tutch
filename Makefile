# tutch
# Copyright (C) Andreas Abel, 2001

# ---------------------------------------------------------------
# Please edit the following lines
# ---------------------------------------------------------------

# SML interpreter and/or compiler
sml = sml
mlton = mlton

# Target
tutch = bin/tutch

# ---------------------------------------------------------------
# Do not edit the following lines
# ---------------------------------------------------------------

default : tutch-mlton

all : tutch-sml tutch-mlton

# Build heap image runnable with sml

tutch-sml :
	@echo "Compiling tutch..."
	$(sml) < tutch.sml ;
	sed -e "s#%TUTCHDIR#"`pwd`"#g" \
	    -e "s#%SML#$(sml)#g" bin/.tutch \
	> $(tutch) ;
	chmod a+x $(tutch) ;

# Build binary with MLton

tutch-mlton :
	$(mlton) -output $(tutch) -default-ann 'allowSigWithtype true' src/tutch.mlb

# Quiet run for test suite
tutch-q = $(tutch) -Q

test : test-succeed test-fail

test-succeed :
	$(tutch-q) -r ./doc/examples/prop.req ./doc/examples/prop0.tut ./doc/examples/prop3.tut
	$(tutch-q) -r ./doc/examples/prop.req ./doc/examples/prop1.tut ./doc/examples/prop3.tut
	$(tutch-q) \
	  ./doc/examples/prop4.tut \
	  ./doc/examples/prop0-ann.tut \
	  ./doc/examples/prop3-ann.tut \
	  ./doc/examples/fol.tut \
	  ./doc/examples/arith.tut \
	  ./doc/examples/arith-terms.tut

test-fail :
	! $(tutch-q) ./doc/examples/prop2.tut
	! $(tutch-q) ./doc/examples/struct-ind.tut
