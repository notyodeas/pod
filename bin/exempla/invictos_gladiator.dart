import 'constantes.dart';
import 'gladiator.dart';

class InvictosGladiator {
  String identitatis;
  GladiatorOutput output;
  bool primis;
  List<String> defensiones;
  List<String> impetus;
  InvictosGladiator(this.identitatis, this.output, this.primis, this.defensiones, this.impetus);

  Map<String, dynamic> toJson() => {
        JSON.identitatis: identitatis,
        JSON.output: output.toJson(),
        JSON.primis: primis,
        JSON.defensio: defensiones,
        JSON.impetus: impetus
      };
}

// maby index should be bool