# tutch
# Copyright (C) Andreas Abel, 2001

# ---------------------------------------------------------------
# Please edit the following lines
# ---------------------------------------------------------------

# What is SML/NJ called?
sml = sml

# ---------------------------------------------------------------
# Do not edit the following lines
# ---------------------------------------------------------------

default : tutch

all : tutch

tutch :
	@echo "Compiling tutch..."
	$(sml) < tutch.sml ;
	sed -e "s#%TUTCHDIR#"`pwd`"#g" \
	    -e "s#%SML#$(sml)#g" bin/.tutch \
	> bin/tutch ;
	chmod a+x bin/tutch ;
