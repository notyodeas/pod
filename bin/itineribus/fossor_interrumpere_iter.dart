import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:elliptic/elliptic.dart';
import '../exempla/pera.dart';
import '../server.dart';
import '../exempla/petitio/privatus_clavis.dart';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import "../exempla/constantes.dart";
import 'dart:isolate';

Future<Response> fossorInterrumpere(Request req) async {
    PrivatusClavis pc =
    PrivatusClavis.fromJson(json.decode(await req.readAsString()));
  bool estFurca = bool.parse(req.params['furca']!);
  String privatus = pc.ex;
  String publica = PrivateKey.fromHex(Pera.curve(), privatus).publicKey.toHex();
  if (publica != argumentis!.publicaClavis) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'non habes ius truncum in hac nodo producendi', message: 'you do not have the right to produce a block on this node')));
  }
    Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
  Obstructionum prior =
  await Obstructionum.acciperePrior(directorium);
  ReceivePort rp = ReceivePort();  
    stamina.interrumpereThreads.add(await Isolate.spawn(Obstructionum.interrumpere,
      List<dynamic>.from([estFurca, on, prior,
      lo, par!.liberTransactions, par!.fixumTransactions, par!.expressiTransactions,
      par!.connexiaLiberExpressis, par!.siRemotiones, par!.rationibus, par!.solucionisRationibus, par!.fissileSolucionisRationibus, 
      par!.inritaTransactions, argumentis!.publicaClavis, rp.sendPort])));
  rp.listen((nuntius) async {
    Obstructionum obstructionum = nuntius as Obstructionum;
    stamina.interrumpereThreads.forEach((et) => et.kill());
    await par!.syncBlock(obstructionum);
    await par!.removeLiberTransactions(obstructionum.interiore.liberTransactions.map((e) => e.interiore.identitatis).toList());
    await par!.removeFixumTransactions(obstructionum.interiore.fixumTransactions.map((e) => e.interiore.identitatis).toList());
    // await par!.removeSiRemotionems(obstructionum.interiore.siRemotiones.map((e) => e.interiore.signatureInterioreSiRemotionem!).toList());
  });
  return Response.ok(json.encode({
    "nuntius": "coepi interrumpere fossores",
    "message": "started interrumpere miner",
    "threads": stamina.interrumpereThreads.length
  }));
}
Future<Response> prohibereInterrumpere(Request req) async {
  for (int i = 0; i < stamina.interrumpereThreads.length; i++) {
    stamina.interrumpereThreads[i].kill(priority: Isolate.immediate);
  }
  return Response.ok(json.encode({
    "nuntius": "bene substitit interrumpere miner",
    "message": "succesfully stopped interrumpere miner",
  }));
}