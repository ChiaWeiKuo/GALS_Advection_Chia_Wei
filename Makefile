# Warnings
WFLAGS	:= -Wall -Wextra -Wsign-conversion -Wsign-compare

# Optimization and architecture
OPT  := -O3
ARCH	:= -march=native

# Language standard
CCSTD	:= -std=c99
CXXSTD	:= -std=c++11
CXXXSTD := -std=c++14

# Linker options
LDOPT	:= $(OPT)
LDFLAGS := -fopenmp
BIN = "/usr/local/gcc/6.4.0/bin/gcc"
.DEFAULT_GOAL := all

.PHONY: debug
debug : OPT  := -O0 -g -fno-omit-frame-pointer -fsanitize=addres
debug : LDFLAGS := -fsanitize=address
debug : ARCH :=
debug : $(EXEC)

all : GALS_Advection

GALS_Advection: GALS_Advection_OpenMP.cpp
	@ echo Compiling $<...
	mpicxx $(CXXXSTD) GALS_Advection_OpenMP.cpp -o GALS_Advection $(WFLAGS) $(OPT) $(LDFLAGS) $(CFLAGS) $(CXXSTD) #-pg -fprofile-arcs -ftest-coverage

# TODO: add targets for building executables


.PHONY: clean
clean:
	rm -f *.o *.exe *.dat *.out *.txt
	rm GALS_Advection
