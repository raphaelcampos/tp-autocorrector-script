# Corretor automático para Trabalhos Práticos de AEDS II

Esse repositório contém um script para correćão automática dos trabalhos práticos dos alunos da disciplina de AEDS II da Universidade Federal de Minas Gerais

## Dependências

 - Sistema operacional capaz de rodar shell script;
 - Compilador gcc instalado;
 - dtrx “Do The Right Extraction.” precisa estar instalado.

## Modo de uso

```bash correction.sh tps.zip```

O arquivo tps.zip é o arquivo zip gerado pelo moodle com todos os tps dos alunos.
O script vai criar um pasta **results** com as respostas, erros de compilaćão e execucao de cada aluno.
Cada aluno tera uma pasta dentro de **results** contendo os resultados da execucao. Além disso,
na raiz da pasta **results** será criado um arquivo com resultados sumarizados.

