# ProcessadorV1 - Simulação em Verilog

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
