import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:ez_validator/ez_validator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:tuple/tuple.dart';
import '../auxiliatores/fossor_praecipuus.dart';
import '../auxiliatores/requiritur_in_probationem.dart';
import '../exempla/errors.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import '../exempla/constantes.dart';
import '../server.dart';
final expressiSchema = EzSchema.shape({
  'ex': EzValidator<String>().required(),
  'victima': EzSchema.shape({
    'identitatis': EzValidator<String>().required(),
    'primis': EzValidator().boolean().required()
  })
}, noUnknown: true);
Future<Response> fossorExpressi(Request req) async {
  bool estFurca = bool.parse(req.params['furca']!);
  try {
    Map<String, dynamic> corpus = json.decode(await req.readAsString());
    final ez = expressiSchema.catchErrors(corpus);
    if (ez.isNotEmpty) return Response.badRequest(body: json.encode(BadRequest(code: 4, nuntius: 'nuntius', message: json.encode(ez) )));
    IncipitPugna ip =
    IncipitPugna.fromJson(corpus);
    Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    Obstructionum prior = await Obstructionum.acciperePrior(directorium);
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    if (!File('${directorium.path}/${Constantes.caudices}0.txt').existsSync()) {
      return Response.badRequest(
          body: json.encode({
        "code": 0,
        "nuntius": "adhuc expectans incipio obstructionum",
        "message": "Still waiting on incipio block"
      }));
    }
    Gladiator? gladiatorVictima =
    await Obstructionum.grabGladiator(ip.victima.identitatis, lo);
    if (gladiatorVictima == null) {
      return Response.badRequest(
          body: json.encode({
        "code": 1,
        "nuntius": "Gladiator non inveni",
        "message": "Gladiator not found"
      }));
    }
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ip.ex);
    if (await Obstructionum.gladiatorConfodiantur(
      ip.victima.primis, ip.victima.identitatis, pk.publicKey.toHex(), lo)) {
      return Response.badRequest(
          body: json.encode({
        "code": 2,
        "message": "Non te oppugnare",
        "english": "Can not attack yourself"
      }));
    }
    String publica = pk.publicKey.toHex();
    if (publica != argumentis!.publicaClavis) {
      return Response.badRequest(body: json.encode(BadRequest(code: 3, nuntius: 'doleo te solum posse meum confussum vel expressi cum clavis privatis quae ad argumentum producentis in nodi launch datam pertinet', message: 'sorry you can only mine a confussus or expressi with the private key that belongs to the argument of producentis given on node launch')));
    }
    Tuple2<String, bool> pg = await Pera.accipereGladiatorIdentitatisPrimis(publica, directorium);
    Gladiator? gladiatorInimicus = await Obstructionum.grabGladiator(pg.item1, lo);
    if (gladiatorInimicus == null) {
      return Response.badRequest(
          body: json.encode({
        "code": 1,
        "nuntius": "Gladiator iam victus aut non inveni",
        "message": "Gladiator already defeaten or not found with your private key"
      }));
    }
    Set<Transactio> lttip = Set();
    lttip.addAll(par!.liberTransactions);
    Iterable<Transactio> ltsr = par!.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null).map((msr) => Transactio.nullam(msr.interiore.siRemotionemInput!.interioreTransactio!));
    lttip.addAll(ltsr);
    List<String> scuta = await RequiriturInProbationem.requiriturInProbationem(pg.item2, pg.item1, ip.victima, lo);    ReceivePort acciperePortus = ReceivePort();
    stamina.expressiThreads.add(await Isolate.spawn(Obstructionum.expressi,
        List<dynamic>.from([estFurca, ip, pg.item2, pg.item1, argumentis!.publicaClavis,
        lo, prior, scuta, gladiatorVictima, gladiatorInimicus, lttip,
        par!.fixumTransactions, par!.expressiTransactions, par!.connexiaLiberExpressis, par!.siRemotiones, par!.rationibus,
        par!.solucionisRationibus, par!.fissileSolucionisRationibus, par!.inritaTransactions, acciperePortus.sendPort])));
    acciperePortus.listen((nuntius) async {
      Obstructionum obstructionum = nuntius as Obstructionum;
      stamina.expressiThreads.forEach((et) => et.kill(priority: Isolate.immediate));
      await par!.syncBlock(obstructionum);
      await par!.removeLiberTransactions(obstructionum.interiore.liberTransactions.map((e) => e.interiore.identitatis).toList());
      await par!.removeFixumTransactions(obstructionum.interiore.fixumTransactions.map((e) => e.interiore.identitatis).toList());
    });
    return Response.ok(json.encode({
      "nuntius": "coepi expressi miner",
      "message": "started expressi miner",
      "threads": stamina.expressiThreads.length 
    }));    
  } on BadRequest catch (e) {
     return Response.badRequest(body: json.encode(e.toJson()));
  } 
}

Future<Response> expressiThreads(Request req) async {
  return Response.ok({"threads": stamina.expressiThreads.length});
}

Future<Response> prohibereExpressi() async {
  stamina.expressiThreads.forEach((e) => e.kill(priority: Isolate.immediate));
  return Response.ok({
    "message": "bene substitit expressi miner",
    "english": "succesfully stopped expressi miner",
  });
}
