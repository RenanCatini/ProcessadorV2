# Diretórios
DIR = build
SRC_DIR = fonte

# Arquivos
SRC = testbench.v
OUTPUT = $(DIR)/output
VCD = $(DIR)/testeProcessador.vcd

# Novos arquivos necessários para compilação
SOURCES = $(SRC_DIR)/counter.v \
          $(SRC_DIR)/unidControle.v \
          $(SRC_DIR)/registrador.v \
          $(SRC_DIR)/extensor_sinal.v \
          $(SRC_DIR)/multiplexador.v \
          $(SRC_DIR)/ULA.v \
          $(SRC_DIR)/decodificador.v \
          $(SRC_DIR)/decode_reg.v \
          $(SRC_DIR)/program_counter.v \
          $(SRC_DIR)/instruction_memory.v

all: run

$(DIR):
	@mkdir -p $(DIR)

$(OUTPUT): $(SRC) $(SOURCES) | $(DIR)
	@iverilog -I$(SRC_DIR) -o $(OUTPUT) $(SRC)

run: $(OUTPUT)
	@vvp $(OUTPUT)

wave: run
	@echo "Abrindo GTKWave..."
	@gtkwave $(VCD)

clean:
	@echo "Limpando..."
	@rm -rf $(DIR)

# Comandos de ajuda
help:
	@echo "Comandos disponíveis:"
	@echo "  make run   - Compila e executa a simulação"
	@echo "  make wave  - Executa e abre GTKWave"
	@echo "  make clean - Remove arquivos de build"

.PHONY: all run wave clean help