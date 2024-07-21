import 'dart:ffi';
import 'dart:math';

enum Direcao { top, down, left, right }

class PosicaoBase {
  int linha = 0;
  int coluna = 0;
}

class PosicoesLivres {
  Direcao direcao = Direcao.top;
  int casasLivres = 0;

  PosicoesLivres(Direcao _direcao, int _casasLivres) {
    direcao = _direcao;
    casasLivres = _casasLivres;
  }
}

class Palavra {
  String nome = '';
  PosicaoBase posicao = PosicaoBase();
  Direcao direcao = Direcao.top;
  bool livre = true;

  // ignore: no_leading_underscores_for_local_identifiers
  Palavra(String _nome, PosicaoBase _posicao, Direcao _direcao, bool _livre) {
    nome = _nome;
    posicao = _posicao;
    direcao = _direcao;
    livre = _livre;
  }
}

class CrossWord {
  List<List<dynamic>> matrix = [];
  List<Palavra> palavras = [];
  List<String> listPalavras = ['bola', 'banana', 'santo', 'pipa', 'disco'];
  List<PosicoesLivres> listPosicoesLivres = [];
  final matrixLinhas = 10;
  final matrizColunas = 10;

  CrossWord() {
    listPalavras.forEach(
        (v) => palavras.add(Palavra(v, PosicaoBase(), Direcao.top, false)));
  }

  PosicaoBase getRandomPosition() {
    PosicaoBase p = PosicaoBase();
    final random = Random();
    p.linha = random.nextInt(matrixLinhas);
    p.coluna = random.nextInt(matrixLinhas);
    return p;
  }

  initMatrix() {
    for (var i = 0; i < matrixLinhas; i++) {
      List<dynamic> list = [];
      for (var j = 0; j < matrizColunas; j++) {
        list.add(null);
      }
      matrix.add(list);
    }
  }

  printMatrix() {
    String result = '';
    print(palavras.length);
    for (var i = 0; i < matrixLinhas; i++) {
      result = '';
      for (var j = 0; j < matrizColunas; j++) {
        result += '${matrix[i][j]}-';
      }
      print(result);
      print('\n');
    }
  }

  getSpace(PosicaoBase posicao) {
    listPosicoesLivres = [];
    listPosicoesLivres.add(_getSpaceRight(posicao));
    listPosicoesLivres.add(_getSpaceLeft(posicao));
    listPosicoesLivres.add(_getSpaceTop(posicao));
    listPosicoesLivres.add(_getSpaceDown(posicao));
    listPosicoesLivres.forEach((p) {
      print(
          ' coluna base de calculo - coluna:${posicao.coluna} linha:${posicao.linha} ${p.casasLivres} na direção ${p.direcao}');
    });
  }

  PosicoesLivres _getSpaceRight(PosicaoBase posicao) {
    bool naoAchou = true;
    int c = posicao.coluna;
    while (c <= matrizColunas - 1 && naoAchou) {
      if (matrix[posicao.linha][c] == null) {
        c++;
      } else {
        naoAchou = false;
      }
    }
    return PosicoesLivres(Direcao.right, (c) - posicao.coluna);
  }

  PosicoesLivres _getSpaceLeft(PosicaoBase posicao) {
    bool naoAchou = true;
    int c = posicao.coluna;
    while (c >= 0 && naoAchou) {
      if (matrix[posicao.linha][c] == null) {
        c--;
      } else {
        naoAchou = false;
      }
    }
    return PosicoesLivres(Direcao.left, posicao.coluna - c - 1);
  }

  PosicoesLivres _getSpaceTop(PosicaoBase posicao) {
    bool naoAchou = true;
    int l = posicao.linha;
    while (l >= 0 && naoAchou) {
      if (matrix[l][posicao.coluna] == null) {
        l--;
      } else {
        naoAchou = false;
      }
    }
    print('VALOR DE L $l');
    return PosicoesLivres(Direcao.top, posicao.linha - l);
  }

  PosicoesLivres _getSpaceDown(PosicaoBase posicao) {
    bool naoAchou = true;
    int l = posicao.linha;
    while (l <= matrixLinhas - 1 && naoAchou) {
      if (matrix[l][posicao.coluna] == null) {
        l++;
      } else {
        naoAchou = false;
      }
    }
    print('VALOR DE L $l');
    return PosicoesLivres(Direcao.down, l - posicao.linha + 1 );
  }
}
