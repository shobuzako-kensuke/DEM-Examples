# Intel Fortran ===============================================================#
# COMPILER = ifx
# FFLAGS   = -O2 -xHost -ipo -fiopenmp -convert big_endian -static-intel

# gfortran ====================================================================#
COMPILER = gfortran
FFLAGS   = -O2 -fopenmp -fconvert=big-endian

#==============================================================================#
#=========================== NOT CHANGE BELOW =================================#
#==============================================================================#

#=========================#
#  file name              #
#=========================#
TARGET = start_calculation

#=========================#
# write all files as .f90 #
#=========================#
COMMON_MOD = \
	input.f90 \
	global_variables.f90 \
	lib_file_operations.f90 \
	set_system.f90 \
	set_background_cell.f90 \
	cal_background_cell.f90 \
	cal_EOM_AME.f90 \
	cal_boundary.f90 \
	cal_U_max.f90 \
	out_input.f90 \
	out_system_info.f90 \
	out_data.f90 \
	out_progress.f90 \
	main.f90
	
#=========================#
#  write all files as .o  #
#=========================#
OBJECTS = \
	input.o \
	global_variables.o \
	lib_file_operations.o \
	set_system.o \
	set_background_cell.o \
	cal_background_cell.o \
	cal_EOM_AME.o \
	cal_boundary.o \
	cal_U_max.o \
	out_input.o \
	out_system_info.o \
	out_data.o \
	out_progress.o \
	main.o
	
#=========================#
#  define rules: f90 >> o #
#=========================#
.SUFFIXES:
.SUFFIXES: .o .f90

#=========================#
#  compile .f90 >> .o     #
#=========================#
.f90.o:
	$(COMPILER) -c $(FFLAGS) $<

$(TARGET): $(OBJECTS)
	$(COMPILER) $(FFLAGS) $(FLIBS) -o $(TARGET) $(OBJECTS)
	@echo + -------------------------------------------------------- +
	@echo [message] All programs have been successfully compiled.
	@echo [message] Please input: ./start_calculation
	@echo + -------------------------------------------------------- +

#=========================#
#  if module changed      #
#=========================#
$(OBJECTS): $(COMMON_MOD)

#=========================#
#  make clean             #
#=========================#
# Linux=@rm, Command Prompt=@del
.PHONY: clean
clean:
	@rm -rf $(TARGET)     $(OBJECTS) *.mod
#	@del    $(TARGET).exe $(OBJECTS) *.mod
	@echo + -------------------------------------------------------- +
	@echo [message] make clean
	@echo + -------------------------------------------------------- +

# END #
