import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:elliptic/elliptic.dart';
import 'dart:isolate';
import '../auxiliatores/fossor_praecipuus.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import '../server.dart';


Future<Response> fossorEfectus(Request req) async {
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  bool estFurca = bool.parse(req.params['furca']!);
  String privatus = req.params['privatus']!;
  if (PrivateKey.fromHex(Pera.curve(), privatus).publicKey.toHex() != argumentis!.publicaClavis) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'non habes ius truncum in hac nodo producendi', message: 'you do not have the right to produce a block on this node')));
  }
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
  List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
  Obstructionum prior =
  await Obstructionum.acciperePrior(directorium);
  ReceivePort rp = ReceivePort();  
    stamina.efectusThreads.add(await Isolate.spawn(Obstructionum.efectus,
      List<dynamic>.from([estFurca, incipio, on, prior,
      lo, par!.liberTransactions, par!.fixumTransactions, par!.expressiTransactions,
      par!.connexiaLiberExpressis, par!.siRemotiones, par!.rationibus, par!.solucionisRationibus, par!.fissileSolucionisRationibus, 
      par!.inritaTransactions, argumentis!.publicaClavis, rp.sendPort])));
  rp.listen((nuntius) async {
    Obstructionum obstructionum = nuntius as Obstructionum;
    stamina.efectusThreads.forEach((et) => et.kill());
    await par!.syncBlock(obstructionum);
    await par!.removeLiberTransactions(obstructionum.interiore.liberTransactions.map((e) => e.interiore.identitatis).toList());
    await par!.removeFixumTransactions(obstructionum.interiore.fixumTransactions.map((e) => e.interiore.identitatis).toList());
    // await par!.removeSiRemotionems(obstructionum.interiore.siRemotiones.map((e) => e.interiore.signatureInterioreSiRemotionem!).toList());
  });
  return Response.ok(json.encode({
    "nuntius": "coepi efectus fossores",
    "message": "started efectus miner",
    "threads": stamina.efectusThreads.length
  }));
}


Future<Response> efectusThreads(Request req) async {
  return Response.ok(json.encode({
    "relatorum": stamina.efectusThreads.length,
    "threads": stamina.efectusThreads.length
  }));
}

Future<Response> prohibereEfectus(Request req) async {
  for (int i = 0; i < stamina.efectusThreads.length; i++) {
    stamina.efectusThreads[i].kill(priority: Isolate.immediate);
  }
  return Response.ok(json.encode({
    "nuntius": "bene substitit efectus miner",
    "message": "succesfully stopped efectus miner",
  }));
}
