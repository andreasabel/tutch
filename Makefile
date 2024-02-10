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
