import 'package:cross/cross.dart';

void main(List<String> arguments) {
  CrossWord cross = CrossWord();
  cross.initMatrix();
  // cross.printMatrix();
  PosicaoBase p = cross.getRandomPosition();
  cross.getSpace(p);
  var x = cross.getNextWord();
  print('PALAVRA SELECIONADA ${x.nome} ${x.direcao}');

  cross.writeWord(p);
  print(cross.palavraAtual.nome);
  cross.printMatrix();
}
