import 'package:cross/cross.dart';

void main(List<String> arguments) {
  CrossWord cross = CrossWord();
  cross.initMatrix();
  // cross.printMatrix();
  PosicaoBase p = cross.getRandomPosition();
  cross.getSpace(p);
  
}
