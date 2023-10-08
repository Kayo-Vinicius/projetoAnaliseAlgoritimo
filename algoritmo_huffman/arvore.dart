class Arvore {
  String chave;
  int valor;
  Arvore? esquerda;
  Arvore? direita;

  Arvore(this.chave, this.valor, this.esquerda, this.direita);

  void addBinario(Arvore? no, String bits, Map<String, String> bitsLetra) {
    if (no == null) return;
    if (!no.chave.startsWith('N')) {
      bitsLetra[no.chave] = bits;
    }
    addBinario(no.direita, bits + '1', bitsLetra);
    addBinario(no.esquerda, bits + '0', bitsLetra);
  }

  void imprimirArvore(Arvore? no, [String nomeNo = '']) {
    if (no == null) return;
    print('$nomeNo${no.chave}: ${no.valor}');
    imprimirArvore(no.direita, '$nomeNo    ');
    imprimirArvore(no.esquerda, '$nomeNo    ');
  }
}
