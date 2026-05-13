import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/invictos_gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/obstructionum_arma.dart';
import '../exempla/pera.dart';
import 'package:tuple/tuple.dart';
import 'dart:io';
import '../exempla/responsio/gladiator_arma.dart';
import '../exempla/responsio/summa_bid_arma.dart';
import '../exempla/telum.dart';
import '../server.dart';
import 'package:collection/collection.dart';
import '../auxiliatores/requiritur_in_probationem.dart';
import '../exempla/petitio/incipit_pugna.dart';
Future<Response> gladiatorInvictos(Request req) async {
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Tuple5<String, GladiatorOutput, bool, List<String>, List<String>>> gladiatores =
      await Obstructionum.invictosGladiatores(directory);
  final List<InvictosGladiator> invictos = [];
  for (Tuple5<String, GladiatorOutput, bool, List<String>, List<String>> gladiator in gladiatores) {
    invictos.add(
        InvictosGladiator(gladiator.item1, gladiator.item2, gladiator.item3, gladiator.item4, gladiator.item5));
  }
  return Response.ok(json.encode(invictos.map((e) => e.toJson()).toList()));
}
Future<Response> gladiatorArmaNecessaria(Request req) async {
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  bool tuusPrimis = bool.parse(req.params['tuus-primis']!);
  String tuusIdentitatis = req.params['tuus-identitatis']!;
  bool victimaPrimis = bool.parse(req.params['victima-primis']!);
  String victimaIdentitatis =req.params['victima-identitatis']!;
  List<String> scuta = await RequiriturInProbationem.requiriturInProbationem(tuusPrimis, tuusIdentitatis, Victima(victimaPrimis, victimaIdentitatis), lo);
  return Response.ok(json.encode(scuta));
}

Future<Response> gladiatorDefenditur(Request req) async {
  String publica = req.params['publica-clavis']!;
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  if (await Pera.isPublicaClavisDefended(publica, lo)) {
    return Response.ok(json.encode({
      "defenditur": true,
      "nuntius": "publica clavis defenditur",
      "message": "the public key is protected"
    }));
  } else {
    return Response.ok(json.encode({
      "defenditur": false,
      "nuntius": "publica clavis non defenditur",
      "message": "the public key is not protected"
    }));
  }
}

Future<Response> gladiatorArma(Request req) async {
  try {
    final String publica = req.params['publica-clavis']!;
    Directory directory =
        Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
    final Tuple2<String, bool> tsb =
        await Pera.accipereGladiatorIdentitatisPrimis(publica, directory);
    final String basisDefensio = await Pera.turpiaGladiatoriaTelum(
        tsb.item2, false, tsb.item1, lo);
    final basisImpetum =
        await Pera.turpiaGladiatoriaTelum(tsb.item2, true, tsb.item1, lo);
    final List<Telum> liberDefensiones =
        await Pera.maximeArma(liber: true, primis: tsb.item2, impetum: false, gladiatorIdentitatis:  tsb.item1, publica: publica, lo: lo);
    final List<Telum> liberImpetus =
        await Pera.maximeArma(liber: true, primis: tsb.item2, impetum: true, gladiatorIdentitatis:  tsb.item1, publica: publica, lo: lo);
    final List<Telum> fixumDefensiones =
        await Pera.maximeArma(liber: false, primis: tsb.item2, impetum: false, gladiatorIdentitatis:  tsb.item1, publica: publica, lo: lo);
    final List<Telum> fixumImpetus =
        await Pera.maximeArma(liber: false, primis: tsb.item2, impetum: true, gladiatorIdentitatis:  tsb.item1, publica: publica, lo: lo);
    GladiatorArma ga = GladiatorArma(
        basisDefensio: basisDefensio,
        basisImpetum: basisImpetum,
        defensionesLiber: liberDefensiones,
        defensionesFixum: fixumDefensiones,
        impetusLiber: liberImpetus,
        impetusFixum: fixumImpetus);
    return Response.ok(json.encode(ga.toJson()));
  } on BadRequest catch (e) {
    return Response.badRequest(body: json.encode(e.toJson()));
  }
}
Future<Response> gladiatorIdentitatis(Request req) async {
  try {
    final String publica = req.params['publica-clavis']!;
    Directory directory =
        Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    Tuple2<String, bool> tp = await Pera.accipereGladiatorIdentitatisPrimis(publica, directory);
    return Response.ok(json.encode({'primis': tp.item2, 'identitatis': tp.item1 }));
  } catch (e) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: '', message: 'public key is not defended')));
  }
    
}

Future<Response> gladiatorSummaBidArma(Request req) async {
  final String probationem = req.params['probationem']!;
  final Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  try {
    BigInt summaBidnotlibers = await Pera.summaBid(true, probationem, lo);
    BigInt summaBidnotfixums = await Pera.summaBid(false, probationem, lo);
    ObstructionumArma oa = await Pera.obstructionumArma(probationem, lo);
    return Response.ok(
        json.encode(SummaBidArma(probationem, summaBidnotlibers, summaBidnotfixums, oa).toJson()));
  } on BadRequest catch (err) {
    return Response.badRequest(body: json.encode(err.toJson()));
  }
}
Future<Response> algiatornotbidantibationem(Request req) async {
  String antibationems = req.params['antibationems']!;
  String privatesnotkeys = req.params['privatenotkeys']!;
  Directory directory =
        Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  final Tuple2<String, bool> tp = await Pera.accipereGladiatorIdentitatisPrimis(privatesnotkeys, directory); 
  final String basisDefensio = await Pera.turpiaGladiatoriaTelum(
      tp.item2, false, tp.item1, lo);
  final basisImpetum =
      await Pera.turpiaGladiatoriaTelum(tp.item2, true, tp.item1, lo);
  final List<Telum> liberDefensiones =
      await Pera.maximeArma(liber: true, primis: tp.item2, impetum: false, gladiatorIdentitatis:  tp.item1, publica: privatesnotkeys, lo: lo);
  final List<Telum> liberImpetus =
      await Pera.maximeArma(liber: true, primis: tp.item2, impetum: true, gladiatorIdentitatis:  tp.item1, publica: privatesnotkeys, lo: lo);
  final List<Telum> fixumDefensiones =
      await Pera.maximeArma(liber: false, primis: tp.item2, impetum: false, gladiatorIdentitatis:  tp.item1, publica: privatesnotkeys, lo: lo);
  final List<Telum> fixumImpetus =
      await Pera.maximeArma(liber: false, primis: tp.item2, impetum: true, gladiatorIdentitatis:  tp.item1, publica: privatesnotkeys, lo: lo);
  GladiatorArma ga = GladiatorArma(
        basisDefensio: basisDefensio,
        basisImpetum: basisImpetum,
        defensionesLiber: liberDefensiones.where((element) => element.probationem == antibationems).toList(),
        defensionesFixum: fixumDefensiones.where((element) => element.probationem == antibationems).toList(),
        impetusLiber: liberImpetus.where((element) => element.probationem == antibationems).toList(),
        impetusFixum: fixumImpetus.where((element) => element.probationem == antibationems).toList()
    );
    return Response.ok(json.encode(ga.toJson()));
  
}