import 'ligacoes_grafo.dart';

LigacoesGrafo ligacoesGrafo = LigacoesGrafo();

void main() {
  int noFinal = ligacoesGrafo.ligacoesGrafo.length;
  int noInicial = 1;

  print(menorCaminhoGrafo(ligacoesGrafo.ligacoesGrafo, noFinal, noInicial));
}

List<int> menorCaminhoGrafo(
    Map<int, Map<int, int>> grafo, int noAtual, int noOrigem) {
  //se o nó atual for igual ao nó de origem retorna uma lista contendo o nó origem
  if (noAtual == noOrigem) {
    return [noOrigem];
  }

  List<int> menorCaminho = [];
  int menorCusto = 99999999999999999;

  grafo.forEach((noAdjacente, custo) {
    if (custo.containsKey(noAtual)) {
      int custoParaAdjacente = custo[noAtual]!;

      // chamada recursiva para a função menorCaminho
      List<int> caminhoParcial =
          menorCaminhoGrafo(grafo, noAdjacente, noOrigem);

      if (caminhoParcial.isNotEmpty) {
        int custoTotal = custoParaAdjacente;

        // calcula o custo total do caminho parcial
        for (int i = 0; i < caminhoParcial.length - 1; i++) {
          custoTotal += grafo[caminhoParcial[i]]![caminhoParcial[i + 1]]!;
        }

        // verfica se o custo total é menor que o menor custo encontrado
        if (custoTotal < menorCusto) {

          // atualiza o menor caminho e o menor custo
          menorCaminho = List.from(caminhoParcial)..add(noAtual);
          menorCusto = custoTotal;
        }
      }
    }
  });

  return menorCaminho;
}
