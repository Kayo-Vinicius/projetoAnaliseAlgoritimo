import 'dart:io';

void main(List<String> args) {
  int dimensao = 5;
  int posicaoInicial = 0;

  List<List<String>> tabuleiro =
      List.generate(dimensao, (_) => List.filled(dimensao, 'X'));
  PasseioCavalo passeioCavalo =
      PasseioCavalo(tabuleiro, posicaoInicial, dimensao);
  passeioCavalo.moverCavalo(posicaoInicial, posicaoInicial, 1);
}

class PasseioCavalo {
  List<List<String>> tabuleiro;
  int posicaoInicial;
  List<PasseioCavalo> filhos = [];
  int dimensao;

  PasseioCavalo(this.tabuleiro, this.posicaoInicial, this.dimensao);

  List<List<int>> movimentosCavalo = [
    [-2, -1],
    [-2, 1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [2, -1],
    [2, 1]
  ];

  // verifica se as casa está vazia
  bool casaVazia(int linha, int coluna, int dimensao) {
    if (dentroLimite(linha, coluna, dimensao) &&
        tabuleiro[linha][coluna] == 'X') {
      return true;
    } else {
      return false;
    }
  }

  // verifica se a jogada esta dentro do limite das dimenções do tabuleiro 
  bool dentroLimite(int linha, int coluna, int dimensao) {
    if (linha >= 0 && coluna >= 0 && linha < dimensao && coluna < dimensao) {
      return true;
    } else {
      return false;
    }
  }


  // move o cavalo para a proxima casa
  moverCavalo(int linha, int coluna, int proximaCasa) {
    tabuleiro[linha][coluna] = 'C';
    imprimirTabuleiro(tabuleiro);

    if (proximaCasa >= dimensao * dimensao) {
      tabuleiro[linha][coluna] = 'C';
      return tabuleiroCompleto();
    }

    // busca na lista de movimentosCavalo os possiveis movimentos
    for (List<int> direcaoMovimento in movimentosCavalo) {
      int novaLinha = linha + direcaoMovimento[0];
      int novaColuna = coluna + direcaoMovimento[1];

      // verifica se a casa é vazia, se for marca ela como visitada
      if (casaVazia(novaLinha, novaColuna, dimensao)) {
        List<List<String>> novoTabuleiro =
            List.from(tabuleiro.map((e) => List<String>.from(e)));

        // cria um novo filho do tabuleiro anterior
        PasseioCavalo novoFilho =
            PasseioCavalo(novoTabuleiro, posicaoInicial, dimensao);

        filhos.add(novoFilho);
        print('Movendo para [$novaLinha, $novaColuna]');

        // chamada recursiva da função de mover o cavalo
        novoFilho.moverCavalo(novaLinha, novaColuna, proximaCasa + 1);
      }
    }

    // aplicando o backtracking nos movimentos do cavalo
    print('BACKTRACKING [$linha, $coluna]');
    tabuleiro[linha][coluna] = 'X';
    return false;
  }

  void imprimirTabuleiro(List<List<String>> tabuleiro) {
    for (List<String> linha in tabuleiro) {
      print(linha);
    }
    print('');
  }

  void tabuleiroCompleto() {
    print('TABULEIRO COMPLETO');
    imprimirTabuleiro(tabuleiro);
    exit(0);
  }
}
