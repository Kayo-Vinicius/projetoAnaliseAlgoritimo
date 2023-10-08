import 'arvore.dart';

String textos = "IFMA CAMPUS CAXIAS";
Arvore arvore = Arvore('', 0, null, null);

void main(List<String> args) {
  var ordenarLetras = ordenaFrequencia(contarLetras(separaLetras));
  var raiz = juntaFrequencia(ordenarLetras);

  arvore.imprimirArvore(raiz);
  Map<String, String> codigos = {};
  arvore.addBinario(raiz, '', codigos);

  for (var chave in codigos.keys) {
    print("${chave}: ${codigos[chave]}");
  }
}

List<String> separaLetras = textos.split("");

contarLetras(List<String> texto) {
  Map<String, int> contador = {};

  for (var i = 0; i < texto.length; i++) {
    String letra = texto[i];

    // verifica se a letra ja existe no contador
    if (contador[letra] == null) {
      contador[letra] = 1;
    } else {
      contador[letra] = contador[letra]! + 1;
    }
  }
  return contador;
}

ordenaFrequencia(Map<String, int> letras) {
  var chaveValor = letras.keys.toList();

  // comparando as chaves do map e as ordena
  chaveValor.sort((chaveA, chaveB) {
    if ((letras[chaveA]! < letras[chaveB]!)) {
      return 1;
    } else if (letras[chaveA]! > letras[chaveB]!) {
      return -1;
    } else {
      return 0;
    }
  });

  // criando um novo map com as letras ordenadas
  Map<String, int> letrasOrdenadas = {};
  for (var chave in chaveValor) {
    letrasOrdenadas[chave] = letras[chave]!;
  }
  print(letrasOrdenadas);
  return letrasOrdenadas;
}

juntaFrequencia(Map<String, int> letras) {
  var novaLista = Map<String, Arvore>.fromIterable(
    letras.keys,
    key: (k) => k,
    value: (k) => Arvore(k, letras[k]!, null, null),
  );
  int i = 1;

  while (novaLista.length > 1) {
    var chaves = novaLista.keys.toList();

    // ordena o mapa por valor em ordem crescente
    chaves.sort((chaveA, chaveB) {
      int comparaValor =
          novaLista[chaveA]!.valor.compareTo(novaLista[chaveB]!.valor);
      if (comparaValor == 0) {
        // se as frequências são iguais, ordena pelo mais recente
        return -chaveA.compareTo(chaveB);
      } else {
        return comparaValor;
      }
    });

    // combina as duas primeiras chaves e seus valores
    var novaChave = 'N' + i.toString();
    var valorLista = novaLista[chaves[0]]!.valor + novaLista[chaves[1]]!.valor;

    // criando uma nova instância da classe Arvore
    // com uma nova chave para o nó, um novo valor para o nó com a soma de dois nós,
    // remove os nós e usa como filhos do novo nó
    var novoNo = Arvore(
        novaChave, valorLista, novaLista[chaves[0]], novaLista[chaves[1]]);

    // remove os nós combinados da lista
    novaLista.remove(chaves[0]);
    novaLista.remove(chaves[1]);

    // adiciona o novo nó à lista
    novaLista[novaChave] = novoNo;

    i++;
  }

  return novaLista.values.first;
}
