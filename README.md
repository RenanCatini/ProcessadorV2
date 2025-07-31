# ProcessadorV2 - Simulação em Verilog

Este projeto contém a implementação de um processador simples em Verilog, com testes automatizados e visualização das simulações.

## Estrutura do Projeto

```
ProcessadorV1/
├── fonte/              # Módulos Verilog (alu.v, registrador.v, etc.)
├── testbench.v         # Arquivo de teste que inclui os módulos
├── Makefile            # Script para compilar, executar e abrir GTKWave
├── build/              # Arquivos gerados (output, .vcd)
└── README.md           # Este arquivo
```

## Pré-requisitos

- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)

## Como usar
1. **Edite o arquivo `instruction_memory.v`**:
   - Localize a seção comentada `// Programa vai aqui`
   - Insira suas instruções no formato:
     ```verilog
     16'h0000: instruction = 16'b101_000_0000000101;  // LDI r0, 5
     16'h0001: instruction = 16'b000_000_001_0000000; // ADD r0, r1
     16'h0002: instruction = 16'b011_000_0000000000;   // HALT
     ```
   - Mantenha o `default` no final para instruções não definidas
     
2. **Formato das instruções**:
   - Use o formato: `16'h[ENDEREÇO]: instruction = 16'b[OPCODE][OPERANDOS];`
   - Endereços devem ser sequenciais (0x0000, 0x0001, etc.)
   - Inclua um `HLT` (011) no final do programa

## Conjunto de Instruções

| Instrução | Opcode | Formato | Operação | Explicação |
|-----------|--------|---------|----------|------------|
| **REP Rx, Ry** | `111` | Tipo R | Rx ← [Ry] | Copia o valor de Ry para Rx |
| **LDI Rx, #D** | `101` | Tipo I | Rx ← D | Carrega valor imediato no registrador |
| **ADD Rx, Ry** | `000` | Tipo R | Rx ← [Rx] + [Ry] | Soma os valores de Rx e Ry |
| **SUB Rx, Ry** | `001` | Tipo R | Rx ← [Rx] - [Ry] | Subtrai Ry de Rx |
| **NAN Rx, Ry** | `010` | Tipo R | Rx ← [Rx] ~& [Ry] | Operação NAND bit a bit |
| **OUT Rx** | `100` | Tipo O | Bus ← [Rx] | Mostra valor de Rx no barramento |
| **BNE Rx, #D** | `110` | Tipo I | Se Rx ≠ D: PC ← PC + D | Salto condicional |
| **HLT** | `011` | Tipo O | Para execução | Finaliza o processador |

### Formatos de Instrução:

1. **Tipo R (Registrador)**:
   ```
   15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
   | Opcode |  Rx  |  Ry  |   Não usado (000000)   |
   ```

2. **Tipo I (Imediato)**:
   ```
   15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
   | Opcode |  Rx  |         Valor Imediato       |
   ```

### Exemplo de Codificação:
```verilog
// ADD r1, r2 → 000 001 010 0000000
16'b000_001_010_0000000

// LDI r3, 5 → 101 011 0000000101
16'b101_011_0000000101

// BNE -3 → 110 000 1111111101 (complemento de 2)
16'b110_000_1111111101;
```

Observações:
- Os valores entre colchetes `[]` indicam o conteúdo do registrador
- O deslocamento em JMP/BNE usa complemento de 2 para saltos negativos
- O campo imediato é sign-extendido quando necessário

### Compilar e executar a simulação

```bash
make
```

### Visualizar a simulação no GTKWave

```bash
make wave
```

### Limpar arquivos gerados

```bash
make clean
```

## Detalhes

- O `Makefile` compila apenas o `testbench.v`, que inclui os módulos da pasta `fonte/`.
- Os arquivos gerados (`output` e `.vcd`) são salvos dentro da pasta `build/`.

---

Feito por Renan 😸
