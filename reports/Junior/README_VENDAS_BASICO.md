# 📊 ZSD_REP_VENDAS_BASICO

## 🎯 Objetivo
Relatório de vendas demonstrando fundamentos sólidos de desenvolvimento ABAP com ALV Grid básico.

## 🛠️ Tecnologias
- **ABAP Core:** Reports, Selection Screens, Internal Tables
- **Class ALV
- **SQL:** Inner Joins otimizados (VBAK + VBAP + KNA1)
- **Performance:** Query única com joins eficientes

## 📋 Funcionalidades

### ✅ **Tela de Seleção Organizada**
- **Bloco 1:** Filtros de data e organização (obrigatórios)
- **Bloco 2:** Filtros opcionais de cliente e material  
- **Bloco 3:** Opções de layout (zebra, totais, otimização)

### ✅ **Processamento de Dados**
- Join otimizado entre 3 tabelas principais
- Validação de entrada obrigatória
- Tratamento de cenário "sem dados"
- Log de performance (quantidade de registros)

### ✅ **ALV Grid Configurado**
- Fieldcat customizado com tipos corretos
- Colunas otimizadas automaticamente
- Zebra pattern opcional
- Totalizadores para valores numéricos
- Cabeçalho informativo completo

### ✅ **Interatividade**
- Double-click no pedido → Navegação para VA03
- Toolbar padrão com funções de export
- Popup de detalhes habilitado
- Salvamento de layout personalizado

## 🖼️ Screenshots

### Tela de Seleção
```
┌─ Filtros de Data e Organização ────────────────┐
│ Data do pedido: [01.01.2025] até [31.12.2025] │
│ Org. vendas:    [____] até [____]              │
│ Canal distrib.: [____] até [____]              │
│ Setor ativid.:  [____] até [____]              │
└────────────────────────────────────────────────┘

┌─ Filtros de Cliente e Material ────────────────┐
│ Cliente:        [____] até [____]              │
│ Material:       [____] até [____]              │
└────────────────────────────────────────────────┘

┌─ Opções de Layout ─────────────────────────────┐
│ ☑ Layout otimizado                             │
│ ☑ Exibir totais                                │
│ ☑ Zebra pattern                                │
└────────────────────────────────────────────────┘
```

### Resultado ALV
```
RELATÓRIO DE VENDAS - ANÁLISE BÁSICA
Período: 01.01.2025 até 31.12.2025
Registros: 1.247 pedidos encontrados
Executado em: 10.09.2025 às 14:30:15

┌──────────┬────────────┬──────────┬─────────────────┬──────┬──────┐
│ Pedido   │ Data       │ Cliente  │ Nome Cliente    │ Qtd  │ Valor│
├──────────┼────────────┼──────────┼─────────────────┼──────┼──────┤
│ 1000001  │ 15.03.2025 │ 100001   │ SAP Brasil LTDA │  100 │ 5.000│
│ 1000001  │ 15.03.2025 │ 100001   │ SAP Brasil LTDA │   50 │ 2.500│
│ 1000002  │ 16.03.2025 │ 100002   │ Petrobras SA    │  200 │15.000│
└──────────┴────────────┴──────────┴─────────────────┴──────┴──────┘
                                                     Total: 22.500
```

## 🚀 Como Usar

### 1. **Instalação**
```abap
" 1. Criar programa via SE38 ou ADT
" 2. Copiar código do arquivo ZSD_REP_VENDAS_BASICO.abap
" 3. Ativar o programa
" 4. Criar transação (opcional): ZSD_VENDAS
```

### 2. **Execução**
```abap
" Opção 1: Direta via SE38
" - Digite: ZSD_REP_VENDAS_BASICO
" - Pressione F8

" Opção 2: Via transação customizada
" - Execute: /nZSD_VENDAS
```

### 3. **Parâmetros Típicos**
```abap
" Filtros obrigatórios:
Data do pedido: 01.01.2025 até 31.03.2025
Org. vendas:    1000 (ou sua organização)

" Filtros opcionais:
Cliente:        Deixar em branco para todos
Material:       Deixar em branco para todos
```

## 📁 Estrutura do Código

### **Selection Screen (Linhas 28-48)**
- 3 blocos organizados logicamente
- Validação de campos obrigatórios
- Títulos dinâmicos via text elements

### **Data Retrieval (Linhas 65-95)**
- Query única com 3 joins otimizados
- Ordenação consistente por pedido/item
- Tratamento de cenário sem dados

### **ALV Configuration (Linhas 98-180)**
- Fieldcat manual para controle total
- Layout responsivo e otimizado
- Cabeçalho informativo completo

### **User Interaction (Linhas 245-255)**
- Double-click integration com VA03
- Parâmetro ID automático para navegação

## 🏆 Conceitos Demonstrados

### **Clean Code**
- ✅ Naming conventions SAP padrão
- ✅ Separação clara de responsabilidades
- ✅ Classe/Métodos organizados por funcionalidades

### **Performance**
- ✅ Single query com joins eficientes
- ✅ Uso de ranges (SELECT-OPTIONS)
- ✅ Otimização automática de colunas
- ✅ Ordenação no banco (não na aplicação)

### **User Experience**
- ✅ Tela de seleção intuitiva e organizada
- ✅ Validações amigáveis com mensagens claras
- ✅ Navegação integrada com transações SAP
- ✅ Cabeçalho informativo com contexto

### **ABAP Fundamentals**
- ✅ Types/Data structures bem definidas
- ✅ Forms modulares e reutilizáveis
- ✅ Exception handling apropriado
- ✅ System fields (sy-*) utilizados corretamente

## 📈 Melhorias Futuras

### **Versão 2.0 (Planejada)**
- [ ] Filtros por status do pedido
- [ ] Agrupamento por cliente/material
- [ ] Export direto para Excel com formatação
- [ ] Drill-down para itens de entrega

### **Versão 3.0 (Visão)**
- [ ] Integração com CDS Views
- [ ] Performance analytics automático
- [ ] Configuração de layout via customizing
- [ ] Multi-idioma support

## 🐛 Troubleshooting

### **Erro: "Nenhum dado encontrado"**
**Causa:** Filtros muito restritivos ou dados de teste ausentes  
**Solução:** Ampliar range de datas ou verificar dados em VBAK

### **Erro: "Informe pelo menos uma Organização"**
**Causa:** Campo obrigatório não preenchido  
**Solução:** Informar organização de vendas válida (ex: 1000)

### **Performance lenta**
**Causa:** Range de datas muito amplo sem outros filtros  
**Solução:** Adicionar filtros de cliente ou material para reduzir dataset



**⭐ Projeto ideal para demonstrar fundamentos sólidos em ABAP!**

</div>

---

[🔙 Reports Overview](../README.md) | [➡️ Próximo Projeto](../ZMM_REP_ESTOQUE_SIMPLES.md)
