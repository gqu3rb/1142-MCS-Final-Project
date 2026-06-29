.PHONY: arr_tb col_tb rowdec_tb gen_tb_all all_tb clean clean_tb_all
# !! All Makefile rules in this file are executed in FinalProject folder !!

SRC_DIR=./src
OBJ_DIR=./obj
TB_ALL_NAME=read_write_SRAM_array_64x32_tb

# run SRAM_array_64x32_tb.sp and store the simulation result into obj folder
arr_tb:
	# creat OBJ_DIR if it doesn't exist	
	mkdir -p $(OBJ_DIR)
	# input SRAM_array_64x32_tb.sp to hspice
	# tell hspice to put all the output files in OBJ_DIR and their name should start with SRAM_array_64x32_tb
	hspice $(SRC_DIR)/SRAM_array_64x32_tb.sp -o $(OBJ_DIR)/SRAM_array_64x32_tb > $(OBJ_DIR)/SRAM_array_64x32_tb.lis

col_tb:
	# creat OBJ_DIR if it doesn't exist	
	mkdir -p $(OBJ_DIR)
	hspice $(SRC_DIR)/Column_tb.sp -o $(OBJ_DIR)/Column_tb > $(OBJ_DIR)/Column_tb.lis

# generate read_write_SRAM_array_64x32_tb.sp by read_write_SRAM_array_64x32_tb.cpp
# and store read_write_SRAM_array_64x32_tb.sp into src folder
gen_tb_all:
	g++ $(SRC_DIR)/global_controller.cpp -o $(SRC_DIR)/global_controller
	./$(SRC_DIR)/global_controller global_controller.sp
	rm ./$(SRC_DIR)/global_controller
	mv global_controller.sp ./$(SRC_DIR)
	g++ $(SRC_DIR)/$(TB_ALL_NAME).cpp -o $(SRC_DIR)/$(TB_ALL_NAME)
	./$(SRC_DIR)/$(TB_ALL_NAME) $(TB_ALL_NAME).sp
	rm ./$(SRC_DIR)/$(TB_ALL_NAME)
	mv $(TB_ALL_NAME).sp ./$(SRC_DIR)

all_tb:
	# creat OBJ_DIR if it doesn't exist	
	mkdir -p $(OBJ_DIR)
	# run with 8 cores
	hspice -mt 8 -i $(SRC_DIR)/$(TB_ALL_NAME).sp -o $(OBJ_DIR)/$(TB_ALL_NAME) > $(OBJ_DIR)/$(TB_ALL_NAME).lis

rowdec_tb:
	mkdir -p $(OBJ_DIR)
	hspice $(SRC_DIR)/6to64_row_decoder_tb.sp -o $(OBJ_DIR)/6to64_row_decoder_tb > $(OBJ_DIR)/6to64_row_decoder_tb.lis

chain_tb:
	mkdir -p $(OBJ_DIR)
	hspice $(SRC_DIR)/delay_chain_measurement.sp -o $(OBJ_DIR)/delay_chain_measurement > $(OBJ_DIR)/delay_chain_measurement.lis

# delete all simulation files in obj folder
clean:
	rm -rf $(OBJ_DIR)

# delete read_write_SRAM_array_64x32_tb.sp in src folder
clean_tb_all:
	rm $(SRC_DIR)/$(TB_ALL_NAME).sp