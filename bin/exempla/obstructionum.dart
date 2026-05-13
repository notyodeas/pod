import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import '../auxiliatores/print.dart';
import './constantes.dart';
import 'connexa_liber_expressi.dart';
import 'gladiator.dart';
import './transactio.dart';
import './utils.dart';
import 'package:hex/hex.dart';
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';
import '../auxiliatores/fossor_praecipuus.dart';
import '../auxiliatores/requiritur_in_probationem.dart';
import "./petitio/incipit_pugna.dart";
import 'pera.dart';
import 'si_remotionem.dart';
import 'solucionis_propter.dart';
import 'telum.dart';
import '../server.dart';
import 'package:encoder/encoder.dart';
import 'package:encoder/encoder.dart';

enum Generare { incipio, efectus, confussus, expressi, interrumpere }

extension GenerareFromJson on Generare {
  static fromJson(String name) {
    switch (name) {
      case 'incipio':
        return Generare.incipio;
      case 'efectus':
        return Generare.efectus;
      case 'confussus':
        return Generare.confussus;
      case 'expressi':
        return Generare.expressi;
      case 'interrumpere':
        return Generare.interrumpere;
    }
  }
}

enum Corrumpo { forumCap, summaDifficultas, numerus, divisa, legalis }

enum QuidFacere { solitum, subter, corrupt }

class InterioreObstructionum {
  final Generare generare;
  final bool estFurca;
  int? numeruCuneosMaximumsOrdinata;
  int obstructionumDifficultas;
  int indicatione;
  BigInt? praemium;
  BigInt nonce;
  final double divisa;
  final BigInt summaObstructionumDifficultas;
  final BigInt forumCap;
  final BigInt liberForumCap;
  final BigInt fixumForumCap;
  BigInt? obstructionumPraemium;
  final List<int> obstructionumNumerus;
  List<String> defensio;
  List<String> impetus;
  final String producentis;
  final String priorProbationem;
  final Gladiator gladiator;
  final Set<Transactio> liberTransactions;
  final Set<Transactio> fixumTransactions;
  final Set<Transactio> expressiTransactions;
  final Set<ConnexaLiberExpressi> connexaLiberExpressis;
  final Set<SiRemotionem> siRemotiones;
  final Set<SolucionisPropter> solucionisRationibus;
  final Set<FissileSolucionisPropter> fissileSolucionisRationibus;
  final Set<InritaTransactio> inritaTransactions;

  InterioreObstructionum(
      {required this.generare,
      required this.estFurca,
      required this.obstructionumDifficultas,
      required this.divisa,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.obstructionumNumerus,
      required this.defensio,
      required this.impetus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions
    })
      : indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero;

  InterioreObstructionum.incipio({ required String ex, required this.producentis, required BigInt praemium})
      : generare = Generare.incipio,
        estFurca = false,
        numeruCuneosMaximumsOrdinata = 7637637637637637637,
        obstructionumDifficultas = 0,
        divisa = 0,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        praemium = BigInt.parse("763000000000000000000"),
        nonce = BigInt.zero,
        summaObstructionumDifficultas = BigInt.zero,
        forumCap = BigInt.zero,
        liberForumCap = BigInt.zero,
        fixumForumCap = BigInt.zero,
        obstructionumNumerus = [0],
        defensio = [],
        impetus = [],
        priorProbationem = '',
        gladiator = Gladiator.nullam(InterioreGladiator.incipio(ex, producentis)),
        liberTransactions = Set<Transactio>.from(
            [Transactio.nullam(InterioreTransactio.praemium(producentis, praemium))]),
        fixumTransactions = Set(),
        expressiTransactions = Set(),
        connexaLiberExpressis = Set(),
        siRemotiones = Set(),
        solucionisRationibus = Set(),
        fissileSolucionisRationibus = Set(),
        inritaTransactions = Set();

  InterioreObstructionum.efectus(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.divisa,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior})
      : generare = Generare.efectus,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(2)],
        impetus = [Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2)];

  InterioreObstructionum.confussus(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.divisa,
      required this.forumCap,
      required this.fixumForumCap,
      required this.liberForumCap,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior})
      : generare = Generare.confussus,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(2)],
        impetus = [Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2)];

  InterioreObstructionum.expressi(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.divisa,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior})
      : generare = Generare.expressi,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(2)],
        impetus = [Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2)];

    InterioreObstructionum.interrumpere({
      required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.divisa,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior
    }) : generare = Generare.interrumpere,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(2)],
        impetus = [Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2), Utils.randomHex(2)];
        


  mine() {
    indicatione = DateTime.now().microsecondsSinceEpoch;
    nonce += BigInt.one;
  }

  Map<String, dynamic> toJson() => {
        JSON.estFurca: estFurca,
        JSON.generare: generare.name.toString(),
        JSON.obstructionumDifficultas: obstructionumDifficultas,
        JSON.divisa: divisa.toString(),
        JSON.indicatione: indicatione,
        JSON.praemium: praemium.toString(),
        JSON.nonce: nonce.toString(),
        JSON.summaObstructionumDifficultas:
            summaObstructionumDifficultas.toString(),
        JSON.forumCap: forumCap.toString(),
        JSON.liberForumCap: liberForumCap.toString(),
        JSON.fixumForumCap: fixumForumCap.toString(),
        JSON.obstructionumNumerus: obstructionumNumerus.toList(),
        JSON.defensio: defensio,
        JSON.impetus: impetus,
        JSON.producentis: producentis,
        JSON.priorProbationem: priorProbationem,
        JSON.gladiator: gladiator.toJson(),
        JSON.liberTransactions:
            liberTransactions.map((e) => e.toJson()).toList(),
        JSON.fixumTransactions:
            fixumTransactions.map((e) => e.toJson()).toList(),
        JSON.expressiTransactions:
            expressiTransactions.map((e) => e.toJson()).toList(),
        JSON.adRemovendumConnexaLiberExpressis:
            connexaLiberExpressis.map((e) => e.toJson()).toList(),
        JSON.siRemotiones: siRemotiones.map((e) => e.toJson()).toList(),
        JSON.solucionisPropter: solucionisRationibus.map((e) => e.toJson()).toList(),
        JSON.fissileSolucionisPropter: fissileSolucionisRationibus.map((e) => e.toJson()).toList(),
        JSON.inritaTransactions: inritaTransactions.map((e) => e.toJson()).toList(),
      }..removeWhere((key, value) => value == null);
  InterioreObstructionum.fromJson(Map jsoschon)
      : estFurca = bool.parse(jsoschon[JSON.estFurca].toString()),
        generare = GenerareFromJson.fromJson(jsoschon[JSON.generare].toString())
            as Generare,
        obstructionumDifficultas =
            int.parse(jsoschon[JSON.obstructionumDifficultas].toString()),
        divisa = double.parse(jsoschon[JSON.divisa].toString()),
        indicatione = int.parse(jsoschon[JSON.indicatione].toString()),
        praemium = jsoschon[JSON.praemium].toString() == 'null' ? null : BigInt.parse(jsoschon[JSON.praemium].toString()),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString()),
        summaObstructionumDifficultas = BigInt.parse(
            jsoschon[JSON.summaObstructionumDifficultas].toString()),
        forumCap = BigInt.parse(jsoschon[JSON.forumCap].toString()),
        liberForumCap = BigInt.parse(jsoschon[JSON.liberForumCap].toString()),
        fixumForumCap = BigInt.parse(jsoschon[JSON.fixumForumCap]),
        obstructionumNumerus = List<int>.from(
            jsoschon[JSON.obstructionumNumerus] as List<dynamic>),
        defensio = List<String>.from(jsoschon[JSON.defensio]),
        impetus = List<String>.from(jsoschon[JSON.impetus]),
        producentis = jsoschon[JSON.producentis].toString(),
        priorProbationem = jsoschon[JSON.priorProbationem].toString(),
        gladiator = Gladiator.fromJson(
            jsoschon[JSON.gladiator] as Map<String, dynamic>),
        liberTransactions = Set<Transactio>.from(
            jsoschon[JSON.liberTransactions]
                    .map((l) => Transactio.fromJson(l as Map<String, dynamic>))
                as Iterable<dynamic>),
        fixumTransactions = Set<Transactio>.from(
            jsoschon[JSON.fixumTransactions]
                    .map((f) => Transactio.fromJson(f as Map<String, dynamic>))
                as Iterable<dynamic>),
        expressiTransactions = Set<Transactio>.from(
            jsoschon[JSON.expressiTransactions]
                    .map((e) => Transactio.fromJson(e as Map<String, dynamic>))
                as Iterable<dynamic>),
        connexaLiberExpressis = Set<ConnexaLiberExpressi>.from(
            (jsoschon[JSON.adRemovendumConnexaLiberExpressis] as List<dynamic>)
                .map((cle) => ConnexaLiberExpressi.fromJson(
                    cle as Map<String, dynamic>))),
        siRemotiones = Set<SiRemotionem>.from((jsoschon[JSON.siRemotiones]
                as List<dynamic>)
            .map((sr) => SiRemotionem.fromJson(sr as Map<String, dynamic>))),
        solucionisRationibus = Set<SolucionisPropter>.from((jsoschon[JSON.solucionisPropter] as List<dynamic>).map((msp) => SolucionisPropter.fromJson(msp as Map<String, dynamic>))),
        fissileSolucionisRationibus = Set<FissileSolucionisPropter>.from((jsoschon[JSON.fissileSolucionisPropter] as List<dynamic>).map((mfsp) => FissileSolucionisPropter.fromJson(mfsp as Map<String, dynamic>))),
        inritaTransactions = Set<InritaTransactio>.from((jsoschon[JSON.inritaTransactions] as List<dynamic>).map((mit) => InritaTransactio.fromJson(mit as Map<String, dynamic>)));

  BigInt numero() {
    BigInt n = BigInt.zero;
    for (int i in obstructionumNumerus) {
      n += BigInt.parse(i.toString());
    }
    return n;
  }

  double divisone() {
    return numero() / BigInt.parse(obstructionumDifficultas.toString());
  }
}

class InFieriObstructionum {
  List<String> gladiatorIdentitatum = [];
  List<String> liberTransactions = [];
  List<String> fixumTransactions = [];
  List<String> expressiTransactions = [];
  List<String> connexaLiberExpressis = [];
  List<String> siRemotionemOutputs = [];
  List<String> siRemotionemInputs = [];
  List<String> solucionisRationibus = [];
  List<String> fissileSolucionisRationibus = [];
  InFieriObstructionum({
      required this.gladiatorIdentitatum,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotionemInputs,
      required this.siRemotionemOutputs,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus 
  });
}

class Obstructionum {
  final InterioreObstructionum interiore;
  late String probationem;
  Obstructionum(this.interiore, this.probationem);
  Obstructionum.incipio(this.interiore)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interiore.toJson())))
            .bytes);
  static Future efectus(List<dynamic> args) async {
    bool estFurca = args[0];
    Obstructionum incipio = args[1];
    List<int> on = args[2];
    Obstructionum prior = args[3];
    List<Obstructionum> lo = args[4];  
    Set<Transactio> liberTransactions = args[5];
    Set<Transactio> fixumTransactions = args[6];
    Set<Transactio> expressiTransactions = args[7];
    Set<ConnexaLiberExpressi> connexiaLiberExpressis = args[8];
    Set<SiRemotionem> siRemotiones = args[9];
    List<Propter> rationibus = args[10];
    Set<SolucionisPropter> solucionisRationibus = args[11];
    Set<FissileSolucionisPropter> fissileSolucionisRationibus = args[12];
    Set<InritaTransactio> inritaTransactions = args[13];
    String producentis = args[14];
    SendPort mitte = args[15] as SendPort;
    Print.nota(nuntius: "effectus fossor onerando", message: 'loading efectus miner');
    final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
    BigInt numerus = await Obstructionum.numeruo(on);
    List<Transactio> lt = [];
    for (Transactio t in liberTransactions) {
      bool potest = true;
      for (TransactioOutput to in t.interiore.outputs) {
        if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo) && !await Pera.isProbationum(to.publicaClavis, lo))  potest = false;
      }
      if (potest == true) lt.add(t);
    }
    FossorPraecipuus fp = FossorPraecipuus();
    fp.accipere(    
      efectus: true, 
      maxime: 7630, 
      llt: lt.toSet(), 
      lft: fixumTransactions, 
      let: expressiTransactions, 
      lcle: connexiaLiberExpressis, 
      lsr: siRemotiones, 
      lp: rationibus.toSet(), 
      lsp: solucionisRationibus, 
      lfsp: fissileSolucionisRationibus, 
      lit: inritaTransactions,
      lo: lo
    );
    if (await Pera.isPublicaClavisDefended(producentis, lo)) fp.llttbi.insert(0, Transactio.nullam(InterioreTransactio.praemium(producentis, incipio.interiore.praemium!)));
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interiore.siRemotionemInput != null)) {
      sr.interiore.siRemotionemInput!.interioreTransactio = null;
    }
    InterioreObstructionum interioreObstructionum = InterioreObstructionum.efectus(
    estFurca: estFurca,
    obstructionumDifficultas: obstructionumDifficultas.length,
    divisa: numerus / await Obstructionum.utSummaDifficultas(lo),
    forumCap: await Obstructionum.accipereForumCap(lo),
    liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
    fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
    summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
    obstructionumNumerus: on,
    producentis: producentis,
    priorProbationem: prior.probationem,
    gladiator: Gladiator.nullam(InterioreGladiator.efectus(
        outputs: InterioreGladiator.egos(fp.lptbi.toList()))),
    liberTransactions: fp.llttbi.toSet(),
    fixumTransactions: fp.lfttbi.toSet(),
    expressiTransactions: fp.lettbi.toSet(),
    connexaLiberExpressis: fp.lcletbi.toSet(),
    siRemotiones: fp.lsrtbi.toSet(),
    solucionisRationibus: fp.lsptbi.toSet(),
    fissileSolucionisRationibus: fp.lfsptbi.toSet(),
    inritaTransactions: fp.littbi.toSet(),
    prior: prior);
    Print.nota(nuntius: 'incepit effectus fossor', message: 'Started efectus miner');
    String probationem = '';
    do {
      interioreObstructionum.mine();
      probationem = HEX.encode(sha512
          .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
          .bytes);
          stdout.write('\r $probationem');
    } while (!probationem
        .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  static Future confussus(List<dynamic> args) async {
    bool estFurca = args[0];
    IncipitPugna ip = args[1];
    bool inimicusPrimis = args[2];
    Obstructionum prior = args[3];
    Gladiator gladiatorVictima = args[4];
    Gladiator gladiatorInimicus = args[5];
    List<Obstructionum> lo = args[6];
    String gladiatorIdentitatis = args[7];
    List<String> scuta = args[8];

    Set<Transactio> liberTransactions = args[9];
    Set<Transactio> fixumTransactions = args[10];
    Set<Transactio> expressiTransactions = args[11];
    Set<ConnexaLiberExpressi> connexiaLiberExpressis = args[12];
    Set<SiRemotionem> siRemotiones = args[13];
    List<Propter> rationibus = args[14];
    Set<SolucionisPropter> solucionisRationibus = args[15];
    Set<FissileSolucionisPropter> fissileSolucionisRationibus = args[16];
    Set<InritaTransactio> inritaTransactions = args[17];
    String producentis = args[18];
    List<Transactio> lt = [];
    Print.nota(nuntius: "confussus fossor onerando", message: 'loading confussus miner');

    for (Transactio t in liberTransactions) {
      bool potest = true;
      for (TransactioOutput to in t.interiore.outputs) {
        if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo) && !await Pera.isProbationum(to.publicaClavis, lo))  potest = false;
      }
      if (potest == true) lt.add(t);
    }
    List<Transactio> ltsr = [];
    ltsr.addAll(lt);
    ltsr.addAll(expressiTransactions);
    ltsr.addAll(siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null).map((msr) => Transactio.nullam(msr.interiore.siRemotionemInput!.interioreTransactio!)));
        COE coe = await COE.computo(victimaPrimis: ip.victima.primis, inimicusPrimis: inimicusPrimis, maxime: 7630, ex: ip.ex, prior: prior, gladiatorVictima: gladiatorVictima, gladiatorInimicus: gladiatorInimicus, llt: ltsr, lo: lo);
    FossorPraecipuus fp = FossorPraecipuus.coe(
      llttbi: coe.llt, 
      lfttbi: coe.lft
    );

    fp.accipere(
      efectus: false, 
      maxime: coe.maxime, 
      llt: ltsr, 
      lft: fixumTransactions,
      let: expressiTransactions, 
      lcle: connexiaLiberExpressis, 
      lsr: siRemotiones, 
      lp: rationibus, 
      lsp: solucionisRationibus, 
      lfsp: fissileSolucionisRationibus, 
      lit: inritaTransactions,
      lo: lo
    );
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interiore.siRemotionemInput != null)) {
        sr.interiore.siRemotionemInput?.interioreTransactio = null;
    }
    // final primis = await Pera.isPrimis(publica, directorium);
    // final gladiatorIdentitatis =
    //     await Pera.accipereGladiatorIdentitatis(publica, directorium);
    // List<String> scuta = await RequiriturInProbationem.requiriturInProbationem(primis, gladiatorIdentitatis, ip.victima, lo);
    List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
    BigInt numerus = await Obstructionum.numeruo(on);
    final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interiore.siRemotionemInput != null)) {
        sr.interiore.siRemotionemInput?.interioreTransactio = null;
    }
    InterioreObstructionum interioreObstructionum = InterioreObstructionum.confussus(
      estFurca: estFurca,
      obstructionumDifficultas: obstructionumDifficultas.length,
      divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
      forumCap: await Obstructionum.accipereForumCap(lo),
      liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
      fixumForumCap:
          await Obstructionum.accipereForumCapLiberFixum(false, lo),
      summaObstructionumDifficultas:
          await Obstructionum.utSummaDifficultas(lo),
      obstructionumNumerus: on,
      producentis: producentis,
      priorProbationem: prior.probationem,
      gladiator: Gladiator.nullam(InterioreGladiator.ce(input: 
      await InterioreGladiator.cegi(privatusClavis: ip.ex, inimicus: 
      GladiatorInputPar(inimicusPrimis, gladiatorIdentitatis), 
      victima: GladiatorInputPar(ip.victima.primis, ip.victima.identitatis), lo: lo))),
      liberTransactions: fp.llttbi.toSet(),
      fixumTransactions: fp.lfttbi.toSet(),
      expressiTransactions: fp.lettbi.toSet(),
      connexaLiberExpressis: fp.lcletbi.toSet(),
      siRemotiones: fp.lsrtbi.toSet(),
      solucionisRationibus: fp.lsptbi.toSet(),
      fissileSolucionisRationibus: fp.lfsptbi.toSet(),
      inritaTransactions: fp.littbi.toSet(),
      prior: prior);
    List<String> toCrack = scuta;
    SendPort mitte = args[19] as SendPort;
    String probationem = '';
    Print.nota(nuntius: 'incepit confussus fossor', message: 'Started confussus miner');
    while (true) {
      do {
        interioreObstructionum.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
            .bytes);
        stdout.write('\r $probationem');
      } while (!probationem
          .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
          
      if (!toCrack.every((tc) => probationem.contains(tc))) {
        continue;
      } else {
        break;
      }
    }
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  static Future expressi(List<dynamic> args) async {
    bool estFurca = args[0];
    IncipitPugna ip = args[1];
    bool primis = args[2];
    String gladiatorIdentitatis = args[3];
    String producentis = args[4];
    List<Obstructionum> lo = args[5];
    Obstructionum prior = args[6];
    List<String> toCrack = args[7] as List<String>;
    Gladiator gladiatorVictima = args[8];
    Gladiator gladiatorInimicus = args[9];
    Set<Transactio> lttip = args[10];
    Set<Transactio> fixumTransactions = args[11];
    Set<Transactio> expressiTransactions = args[12];
    Set<ConnexaLiberExpressi> connexiaLiberExpressis = args[13];
    Set<SiRemotionem> siRemotiones = args[14];
    List<Propter> rationibus = args[15];
    Set<SolucionisPropter> solucionisRationibus = args[16];
    Set<FissileSolucionisPropter> fissileSolucionisRationibus = args[17];
    Set<InritaTransactio> inritaTransactions = args[18];
    List<Propter> lp = [];
    gladiatorInimicus.interiore.outputs.map((o) => o.rationibus).forEach(lp.addAll);
    lttip.addAll(prior.interiore.expressiTransactions);
    
    COE coe = await COE.computo(victimaPrimis: ip.victima.primis, 
    inimicusPrimis: primis, maxime: 7630 - prior.interiore.expressiTransactions.length, ex: ip.ex, prior: prior, gladiatorVictima: gladiatorVictima, gladiatorInimicus: gladiatorInimicus, llt: lttip.toList(), lo: lo);
    List<Transactio> lt = [];
    for (Transactio t in lttip) {
      bool potest = true;
      for (TransactioOutput to in t.interiore.outputs) {
        if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo) && !await Pera.isProbationum(to.publicaClavis, lo))  potest = false;
      }
      if (potest == true) lt.add(t);
    }
    FossorPraecipuus fp = FossorPraecipuus.coe(
      llttbi: coe.llt, 
      lfttbi: coe.lft, 
    );
    fp.accipere(      
      efectus: false,
      maxime: coe.maxime, 
      llt: lt, 
      lft: fixumTransactions, 
      let: expressiTransactions, 
      lcle: connexiaLiberExpressis, 
      lsr: siRemotiones, 
      lp: rationibus, 
      lsp: solucionisRationibus,
      lfsp: fissileSolucionisRationibus,
      lit: inritaTransactions,
      lo: lo
    );
    SendPort mitte = args[19] as SendPort;
    final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
    List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
    BigInt numerus = await Obstructionum.numeruo(on);
    fp.llttbi.addAll(prior.interiore.expressiTransactions.where((e) => lp.any((p) => p.interiore.publicaClavis != e.interiore.dominus && p.interiore.publicaClavis != e.interiore.recipiens)));
    InterioreObstructionum interioreObstructionum = InterioreObstructionum.expressi(
      estFurca: estFurca,
      obstructionumDifficultas: obstructionumDifficultas.length,
      divisa: (numerus / await Obstructionum.utSummaDifficultas(lo)),
      forumCap: await Obstructionum.accipereForumCap(lo),
      liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
      fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
      summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
      obstructionumNumerus: on,
      producentis: producentis,
      priorProbationem: prior.probationem,
      gladiator: Gladiator.nullam(InterioreGladiator.ce(input: 
      await InterioreGladiator.cegi(privatusClavis: ip.ex, 
      inimicus: GladiatorInputPar(primis, gladiatorIdentitatis), 
      victima: GladiatorInputPar(ip.victima.primis, ip.victima.identitatis), lo: lo))),
      liberTransactions: fp.llttbi.toSet(),
      fixumTransactions: fp.lfttbi.toSet(),
      expressiTransactions: fp.lettbi.toSet(),
      connexaLiberExpressis: fp.lcletbi.toSet(),
      siRemotiones: fp.lsrtbi.toSet(),
      solucionisRationibus: fp.lsptbi.toSet(),
      fissileSolucionisRationibus: fp.lfsptbi.toSet(),
      inritaTransactions: fp.littbi.toSet(),
      prior: prior);
    String probationem = '';
    Print.nota(nuntius: 'incepit expressi fossor', message: 'Started expressi miner');
    while (true) {
      do {
        interioreObstructionum.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
            .bytes);
          stdout.write('\r $probationem');
      } while (!probationem.startsWith('0' *
              (interioreObstructionum.obstructionumDifficultas / 2).ceil()) ||
          !probationem.endsWith('0' *
              (interioreObstructionum.obstructionumDifficultas / 2).ceil()));
      if (!toCrack.every((tc) => probationem.contains(tc))) {
        continue;
      } else {
        break;
      }
    }
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }
  static Future interrumpere(List<dynamic> args) async {
    bool estFurca = args[0];
    List<int> on = args[1];
    Obstructionum prior = args[2];
    List<Obstructionum> lo = args[3];  
    Set<Transactio> liberTransactions = args[4];
    Set<Transactio> fixumTransactions = args[5];
    Set<Transactio> expressiTransactions = args[6];
    Set<ConnexaLiberExpressi> connexiaLiberExpressis = args[7];
    Set<SiRemotionem> siRemotiones = args[8];
    List<Propter> rationibus = args[9];
    Set<SolucionisPropter> solucionisRationibus = args[10];
    Set<FissileSolucionisPropter> fissileSolucionisRationibus = args[11];
    Set<InritaTransactio> inritaTransactions = args[12];
    String producentis = args[13];
    SendPort mitte = args[14] as SendPort;
    Print.nota(nuntius: "interrumpere fossor onerando", message: 'loading interrumpere miner');
    final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
    BigInt numerus = await Obstructionum.numeruo(on);
    List<Transactio> lt = [];
    for (Transactio t in liberTransactions) {
      bool potest = true;
      for (TransactioOutput to in t.interiore.outputs) {
        if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo) && !await Pera.isProbationum(to.publicaClavis, lo))  potest = false;
      }
      if (potest == true) lt.add(t);
    }
    FossorPraecipuus fp = FossorPraecipuus();
    fp.accipere(    
      efectus: true, 
      maxime: 7630, 
      llt: lt.toSet(), 
      lft: fixumTransactions, 
      let: expressiTransactions, 
      lcle: connexiaLiberExpressis, 
      lsr: siRemotiones, 
      lp: rationibus.toSet(), 
      lsp: solucionisRationibus, 
      lfsp: fissileSolucionisRationibus, 
      lit: inritaTransactions,
      lo: lo
    );
    print('herestheprob');
    print(fp.lettbi.toSet().map((e) => e.toJson()));
    for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interiore.siRemotionemInput != null)) {
      sr.interiore.siRemotionemInput!.interioreTransactio = null;
    }
    InterioreObstructionum interioreObstructionum = InterioreObstructionum.interrumpere(
    estFurca: estFurca,
    obstructionumDifficultas: obstructionumDifficultas.length,
    divisa: numerus / await Obstructionum.utSummaDifficultas(lo),
    forumCap: await Obstructionum.accipereForumCap(lo),
    liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
    fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
    summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
    obstructionumNumerus: on,
    producentis: producentis,
    priorProbationem: prior.probationem,
    gladiator: Gladiator.nullam(InterioreGladiator.interrumpere()),
    liberTransactions: fp.llttbi.toSet(),
    fixumTransactions: fp.lfttbi.toSet(),
    expressiTransactions: fp.lettbi.toSet(),
    connexaLiberExpressis: fp.lcletbi.toSet(),
    siRemotiones: fp.lsrtbi.toSet(),
    solucionisRationibus: fp.lsptbi.toSet(),
    fissileSolucionisRationibus: fp.lfsptbi.toSet(),
    inritaTransactions: fp.littbi.toSet(),
    prior: prior);
    Print.nota(nuntius: 'incepit interrumpere fossor', message: 'Started interrumpere miner');
    String probationem = '';
    do {
      interioreObstructionum.mine();
      probationem = HEX.encode(sha512
          .convert(utf8.encode(json.encode(interioreObstructionum.toJson())))
          .bytes);
          stdout.write('\r $probationem');
    } while (!probationem
        .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
    mitte.send(Obstructionum(interioreObstructionum, probationem));

  }
  Map<String, dynamic> toJson() => {
        JSON.interiore: interiore.toJson(),
        JSON.probationem: probationem
      };
  Obstructionum.fromJson(Map<String, dynamic> jsoschon)
      : interiore = InterioreObstructionum.fromJson(
            jsoschon[JSON.interiore] as Map<String, dynamic>),
        probationem = jsoschon[JSON.probationem].toString();

  bool isProbationem() {
    if (probationem ==
        HEX.encode(sha512
            .convert(utf8.encode(json.encode(interiore.toJson())))
            .bytes)) {
      return true;
    }
    return false;
  }

  Future salvareIncipio(Directory dir) async {
    File file = await File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}0.txt')
        .create(recursive: true);
    await File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.exitus}.txt').create(recursive: true);
    await File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.latus}.txt').create(recursive: true);

    await interioreSalvare(file);
  }

  Future salvare(Directory dir) async {
    File file = await File(
            '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${(dir.listSync().length - 1)}.txt')
        .create(recursive: true);
    if (await Utils.fileAmnis(file).length > Constantes.maximeCaudicesFile) {
      file = await File(
              '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${(dir.listSync().length)}.txt')
          .create(recursive: true);
      await interioreSalvare(file);
    } else {
      await interioreSalvare(file);
    }
  }
  Future salvareExitus(Directory dir) async {
    File file = await File(
            '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.exitus}.txt')
        .create(recursive: true);
    await interioreSalvare(file);
  }
  Future salvareLatus(Directory dir) async {
    File file = await File(
            '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.latus}.txt')
        .create(recursive: true);
    await interioreSalvare(file);
  }
  // weird that json encode works here with bigger blocks it does but why out trues not languages choices unmeans out false not languages
  // logics not thats notjsonnotencode unworks there withouts smaller not blocks not its not dids butes reasons
  Future interioreSalvare(File file) async {
    var sink = file.openWrite(mode: FileMode.append);
    sink.write('${json.encode(toJson())}\n');
    await sink.close();
  }

  static Future<Obstructionum> accipereIncipio(Directory directorium) async {
    return Obstructionum.fromJson(json.decode(await Utils.fileAmnis(
            File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}0.txt'))
        .first) as Map<String, dynamic>);
  }

  static Future<Obstructionum> acciperePrior(Directory directorium) async =>
      Obstructionum.fromJson(json.decode(await Utils.fileAmnis(File(
              '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${(directorium.listSync().isNotEmpty ? directorium.listSync().length - 1 : 0)}.txt'))
          .last) as Map<String, dynamic>);

  static Future<Obstructionum> accipereObstructionNumerus(
      List<int> numerus, Directory directory) async {
    File file =
        File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${numerus.length - 1}');
    List<String> lines = await Utils.fileAmnis(file).toList();
    return Obstructionum.fromJson(
        json.decode(lines[numerus.last]) as Map<String, dynamic>);
  }

  static Future<List<GladiatorOutput>> utDifficultas(
      List<Obstructionum> lo) async {
    List<GladiatorInput?> gladiatorInitibus = [];
    List<Tuple3<String, GladiatorOutput, bool>> gladiatorOutputs = [];
    lo
        .map((mo) =>
            mo.interiore.gladiator.interiore.input)
        .forEach(gladiatorInitibus.add);
    for (Obstructionum o in lo) {
      for (int i = 0;
          i <
              o.interiore.gladiator.interiore.outputs
                  .length;
          i++) {
        gladiatorOutputs.add(Tuple3<String, GladiatorOutput, bool>(
            o.interiore.gladiator.interiore.identitatis,
            o.interiore.gladiator.interiore.outputs[i],
            (i == 0 ? true : false)));
      }
    }
    gladiatorOutputs.removeWhere((element) => gladiatorInitibus.any((init) =>
        init?.victima.identitatis == element.item1 &&
        init?.victima.primis == element.item3));
    return gladiatorOutputs.map((g) => g.item2).toList();
  }

  static Future<List<Tuple5<String, GladiatorOutput, bool, List<String>, List<String>>>>
      invictosGladiatores(Directory directory) async {
    List<Obstructionum> caudices = [];
    List<GladiatorInput?> gladiatorInitibus = [];
    List<Tuple5<String, GladiatorOutput, bool, List<String>, List<String>>> gladiatorOutputs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      caudices.addAll(await Utils.fileAmnis(
              File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt'))
          .map((b) =>
              Obstructionum.fromJson(json.decode(b) as Map<String, dynamic>))
          .toList());
    }
    caudices.forEach((obstructionum) {
      gladiatorInitibus.add(obstructionum
          .interiore.gladiator.interiore.input);
    });
    for (Obstructionum obstructionum in caudices) {
      for (int i = 0;
          i <
              obstructionum.interiore.gladiator.interiore
                  .outputs.length;
          i++) {
              List<Telum> defensiones =[];
            defensiones.addAll(await Pera.maximeArma(liber: true, primis: i == 0 ? true : false, impetum: false, gladiatorIdentitatis: obstructionum.interiore.gladiator.interiore.identitatis, lo: caudices));
            defensiones.addAll(await Pera.maximeArma(liber: false, primis: i == 0 ? true : false, impetum: false, gladiatorIdentitatis: obstructionum.interiore.gladiator.interiore.identitatis, lo: caudices));
            List<String> scuta = [];
            defensiones.map((d) => d.telum).forEach(scuta.addAll);
            List<Telum> impetus =[];
            impetus.addAll(await Pera.maximeArma(liber: true, primis: i == 0 ? true : false, impetum: true, gladiatorIdentitatis: obstructionum.interiore.gladiator.interiore.identitatis, lo: caudices));
            impetus.addAll(await Pera.maximeArma(liber: false, primis: i == 0 ? true : false, impetum: true, gladiatorIdentitatis: obstructionum.interiore.gladiator.interiore.identitatis, lo: caudices));
            List<String> gladii = [];
            impetus.map((i) => i.telum).forEach(gladii.addAll);
        gladiatorOutputs.add(Tuple5<String, GladiatorOutput, bool, List<String>, List<String>>(
            obstructionum.interiore.gladiator.interiore
                .identitatis,            obstructionum
                .interiore.gladiator.interiore.outputs[i],
            i == 0 ? true : false, scuta, gladii));
      }
    }
    gladiatorOutputs.removeWhere((element) => gladiatorInitibus.any((init) =>
        init?.victima.identitatis == element.item1 &&
        init?.victima.primis == element.item3));
    return gladiatorOutputs;
  }

  static Future<BigInt> utSummaDifficultas(List<Obstructionum> lo) async {
    List<GladiatorOutput> lgo = await Obstructionum.utDifficultas([lo.first]);
    BigInt total = BigInt.from(lgo.length);
    for (Obstructionum o in lo) {
      total += BigInt.from(o.interiore.obstructionumDifficultas);
    }
    return total;
  }

  static Future<List<int>> utObstructionumNumerus(
      Obstructionum obstructionum) async {
    Obstructionum co = Obstructionum.fromJson(
        json.decode(json.encode(obstructionum.toJson())));
    List<int> dif = co.interiore.obstructionumNumerus;
    final int priorObstructionumNumerus = dif[dif.length - 1];
    if (priorObstructionumNumerus < Constantes.maximeCaudicesFile) {
      dif[dif.length - 1]++;
    } else if (priorObstructionumNumerus == Constantes.maximeCaudicesFile) {
      dif.add(0);
    }
    return dif;
  }

  static Future<BigInt> numeruo(List<int> numerus) async {
    BigInt n = BigInt.zero;
    for (int i in numerus) {
      n += BigInt.parse(i.toString());
    }
    return n;
  }

  static Future<List<Obstructionum>> getBlocks(Directory directory) async {
    List<Obstructionum> obs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      await for (String line in Utils.fileAmnis(
          File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt'))) {
        obs.add(
            Obstructionum.fromJson(json.decode(line) as Map<String, dynamic>));
      }
    }
    return obs;
  }
  static Future<List<Obstructionum>> getExitusBlocks() async {
    List<Obstructionum> obs = [];
    await for (String line in Utils.fileAmnis(File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.exitus}.txt'))) {
      obs.add(
          Obstructionum.fromJson(json.decode(line) as Map<String, dynamic>));
    }
    return obs;
  }
  static Future<List<Obstructionum>> getLatusBlocks() async {
    List<Obstructionum> obs = [];
    await for (String line in Utils.fileAmnis(
        File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.latus}.txt'))) {
      obs.add(
          Obstructionum.fromJson(json.decode(line) as Map<String, dynamic>));
    }
    return obs;
  }

  //spirtus looks at the dir not te list of obstructionum
  static Future<bool> gladiatorSpiritus(
      bool primis, String gladiatorId, Directory dir) async {
    List<Obstructionum> obs = await getBlocks(dir);
    List<GladiatorInput?> gis = obs
        .map((o) => o.interiore.gladiator.interiore.input)
        .toList();
    if (gis.any(
        (g) => g?.victima.identitatis == gladiatorId && g?.victima.primis == primis)) {
      return false;
    }
    return true;
  }

  static Future<bool> gladiatorConfodiantur(
      bool primis, String gladiatorId, String publicaClavis, List<Obstructionum> lo) async {
    Obstructionum obsGladiator = lo.singleWhere((swo) =>
        swo.interiore.gladiator.interiore.identitatis ==
        gladiatorId);
    Gladiator gladiator = obsGladiator.interiore.gladiator;
    return gladiator.interiore.outputs[primis ? 0 : 1].rationibus
        .any((r) => r.interiore.publicaClavis == publicaClavis);
  }

  static Future<Gladiator?> grabGladiator(
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    return lo.singleWhereOrNull((obs) =>
                obs.interiore.gladiator.interiore
                    .identitatis ==
                gladiatorIdentitatis) !=
            null
        ? lo
            .singleWhere((obs) => 
                obs.interiore.gladiator.interiore
                    .identitatis ==
                gladiatorIdentitatis)
            .interiore
            .gladiator
        : null;
  }

  static Future<BigInt> accipereForumCap(List<Obstructionum> lo) async {
    final obstructionumPraemium = lo
        .where((obs) =>
            obs.interiore.generare == Generare.incipio ||
            obs.interiore.generare == Generare.efectus)
        .length;
    
    return (BigInt.parse(obstructionumPraemium.toString()) * lo.first.interiore.praemium!);
  }

  static Future<BigInt> accipereForumCapLiberFixum(
      bool liber, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<TransactioInput> initibus = [];
    List<Transactio> txs = [];
    for (Obstructionum o in lo) {
      txs.addAll(liber
          ? o.interiore.liberTransactions
          : o.interiore.fixumTransactions);
    }
    Iterable<List<TransactioInput>> initibuses =
        txs.map((tx) => tx.interiore.inputs);
    for (List<TransactioInput> init in initibuses) {
      initibus.addAll(init);
    }
    for (Transactio tx in txs) {
      for (int t = 0; t < tx.interiore.outputs.length; t++) {
        outputs.add(Tuple3<int, String, TransactioOutput>(
            t,
            tx.interiore.identitatis,
            tx.interiore.outputs[t]));
      }
    }
    outputs.removeWhere((output) => initibus.any((init) =>
        init.transactioIdentitatis == output.item2 &&
        init.index == output.item1));
    BigInt forumCap = BigInt.zero;
    for (TransactioOutput output in outputs.map((output) => output.item3)) {
      forumCap += output.pod;
    }
    return forumCap;
  }

  static bool estNovamNodi(Directory directorium, Obstructionum obs) {
    return directorium.listSync().isEmpty &&
        obs.interiore.generare == Generare.incipio;
  }

  static QuidFacere fortiorEst(
      InterioreObstructionum advenientis, Obstructionum nostrum) {
    if (advenientis.priorProbationem == nostrum.probationem) {
      if (advenientis.summaObstructionumDifficultas >
          nostrum.interiore.summaObstructionumDifficultas) {
        return QuidFacere.solitum;
      } else {
        return QuidFacere.corrupt;
      }
    }
    if (advenientis.divisa < nostrum.interiore.divisa) {
      return QuidFacere.subter;
    }
    return QuidFacere.solitum;
    // todo je kan ook achterlopen
  }

  static Future<Corrumpo> estVerum(
      InterioreObstructionum adventientis, List<Obstructionum> lo) async {
    if (adventientis.forumCap != await Obstructionum.accipereForumCap(lo)) {
      return Corrumpo.forumCap;
    } else if (adventientis.summaObstructionumDifficultas !=
        await Obstructionum.utSummaDifficultas(lo)) {
      return Corrumpo.summaDifficultas;
    } else if (adventientis.obstructionumNumerus !=
        await Obstructionum.utObstructionumNumerus(lo.last)) {
    } else {
      BigInt nuschum = await Obstructionum.numeruo(
          await Obstructionum.utObstructionumNumerus(lo.last));
      if (adventientis.divisa !=
          (nuschum / await Obstructionum.utSummaDifficultas(lo))) {
        return Corrumpo.divisa;
      }
    }
    return Corrumpo.legalis;
  }

  static bool nonFortum(Iterable<Transactio> transactions) {
    for (Transactio transactio in transactions) {
      if (!transactio.isFurantur() && !transactio.validateProbationem()) {
        return false;
      }
    }
    return true;
  }

  Future<bool> validatePraemium(Obstructionum incipio) async {
    if (interiore.fixumTransactions.any((ft) =>
        ft.interiore.transactioSignificatio ==
        TransactioSignificatio.praemium)) {
      return false;
    }
    if (interiore.liberTransactions
            .where((wlt) =>
                wlt.interiore.transactioSignificatio ==
                TransactioSignificatio.praemium)
            .length >
        1) {
      return false;
    }
    Transactio? t = interiore.liberTransactions.singleWhereOrNull(
        (swlt) =>
            swlt.interiore.transactioSignificatio ==
            TransactioSignificatio.praemium);
    if (t == null) return true;
    if (t.interiore.outputs.length > 1) {
      return false;
    }
    return t.interiore.outputs[0].pod ==
        incipio.interiore.liberTransactions
            .singleWhere((swlt) =>
                swlt.interiore.transactioSignificatio ==
                TransactioSignificatio.praemium)
            .interiore
            .outputs[0]
            .pod;
  }

  static Future removereUsqueAd(
      Obstructionum foramen, Directory directorium) async {
    List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
    Obstructionum hNostrum = obss.last;
    if (hNostrum.interiore.obstructionumNumerus.length ==
        foramen.interiore.obstructionumNumerus.length) {
      for (int i = 0;
          i < hNostrum.interiore.obstructionumNumerus.length;
          i++) {
        File f = File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt');
        List<String> ss = await Utils.fileAmnis(f).toList();
        ss.removeRange(foramen.interiore.obstructionumNumerus.last,
            ss.length);
        f.deleteSync();
        f.createSync();
        var sink = f.openWrite(mode: FileMode.append);
        for (String jobs in ss) {
          sink.write('$jobs\n');
        }
        await sink.close();
      }
    }
    //todo else 
  }
  static Future removereExitus(Obstructionum foramen, Directory directorium) async {
    File f = File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.exitus}.txt');
    List<String> ss = await Utils.fileAmnis(f).toList();
    ss.removeAt(ss.indexOf(json.encode(foramen.toJson()))); 
    
  }

  InFieriObstructionum inFieriObstructionum() {
    List<String> gladiatorIdentitatum = [];
    interiore.gladiator.interiore.outputs
        .map((go) => go.rationibus.map((gr) => gr.interiore.publicaClavis))
        .forEach(gladiatorIdentitatum.addAll);
    List<String> lt = interiore.liberTransactions.where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.regularis || wlt.interiore.transactioSignificatio == TransactioSignificatio.ardeat || wlt.interiore.transactioSignificatio == TransactioSignificatio.solucionis || wlt.interiore.transactioSignificatio == TransactioSignificatio.fissile || wlt.interiore.transactioSignificatio == TransactioSignificatio.reliquiae)
        .map((lt) => lt.interiore.identitatis)
        .toList();
    List<String> ft = interiore.fixumTransactions.where((wft) => wft.interiore.transactioSignificatio == TransactioSignificatio.regularis || wft.interiore.transactioSignificatio == TransactioSignificatio.ardeat  || wft.interiore.transactioSignificatio == TransactioSignificatio.solucionis || wft.interiore.transactioSignificatio == TransactioSignificatio.fissile || wft.interiore.transactioSignificatio == TransactioSignificatio.reliquiae)
        .map((ft) => ft.interiore.identitatis)
        .toList();
    List<String> et = interiore.expressiTransactions
        .map((et) => et.interiore.identitatis)
        .toList();
    List<String> cles = interiore.connexaLiberExpressis
        .map((cle) => cle.interioreConnexaLiberExpressi.identitatis)
        .toList();
    List<String> srsonn = interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemOutput != null)
        .map(
            (msr) => msr.interiore.signatureInterioreSiRemotionem!)
        .toList();
    List<String> srsinn = interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null)
        .map((msr) => msr.interiore.siRemotionemInput!.siRemotionemSignature).toList();
    List<String> sp = interiore.solucionisRationibus.map((msp) => msp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis).toList();
    List<String> fsp = interiore.fissileSolucionisRationibus.map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis).toList();
    return InFieriObstructionum(gladiatorIdentitatum: gladiatorIdentitatum, liberTransactions: lt, fixumTransactions: ft, expressiTransactions: et, connexaLiberExpressis: cles, siRemotionemInputs: srsinn, siRemotionemOutputs: srsonn, solucionisRationibus: sp, fissileSolucionisRationibus: fsp);
  }
  
  Future<bool> convalidandumTransform(List<Obstructionum> lo) async {
    List<Transactio> plt = [];
    lo.map((e) => e.interiore.liberTransactions).forEach(plt.addAll);
    Map<String, BigInt> publicaClavisStatera = Map();
    List<TransactioInput> ltit = [];
    interiore.liberTransactions
        .where((wlt) =>
            wlt.interiore.transactioSignificatio ==
            TransactioSignificatio.transform)
        .map((mlt) => mlt.interiore.inputs)
        .forEach(ltit.addAll);
    BigInt totalTransformLiber = BigInt.zero;
    for (TransactioInput ti in ltit) {
      Transactio? t = plt.singleWhereOrNull((x) => x.interiore.identitatis == ti.transactioIdentitatis);
      if (t == null) return false;
      for (TransactioOutput to in t.interiore.outputs) {
          totalTransformLiber += to.pod;
          publicaClavisStatera[to.publicaClavis] = to.pod;
      }
    }
    
    
    List<TransactioOutput> lto = [];
    interiore.fixumTransactions
        .where((wlf) =>
            wlf.interiore.transactioSignificatio ==
            TransactioSignificatio.transform)
        .map((mft) => mft.interiore.outputs)
        .forEach(lto.addAll);
    BigInt totalTransformFixum = BigInt.zero;
    for (TransactioOutput to in lto) {
      totalTransformFixum += to.pod;
      if (to.pod != publicaClavisStatera[to.publicaClavis]) return false;
    }
    return totalTransformLiber == totalTransformFixum;
  }
  // mab y map and addal in inner for loop have conccerns
  Future<bool> convalidandumPerdita(List<Obstructionum> lo) async {
    List<TransactioInput> lti = []; 
    interiore.liberTransactions
    .where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.perdita)
    .map((mlt) => mlt.interiore.inputs)
    .forEach(lti.addAll); 
     List<TransactioOutput> lto = [];
    for (TransactioInput ti in lti) {
      List<Transactio> lt = [];
      lo.map((mo) => mo.interiore.liberTransactions.where((wo) => wo.interiore.identitatis == ti.transactioIdentitatis)).forEach(lt.addAll);
      lt.addAll(interiore.liberTransactions.where((wi) => wi.interiore.identitatis == ti.transactioIdentitatis));
      for (Transactio t in lt) {
        TransactioOutput to = t.interiore.outputs[ti.index];
        if (!Utils.cognoscere(PublicKey.fromHex(Pera.curve(), interiore.producentis), Signature.fromASN1Hex(ti.signature), to)) {
          Print.nota(nuntius: 'combussit pecuniam non signatum producentis amet', message: 'burned money is not signed with the producer key');
          return false;
        } 
        lto.add(to);
      }
    }    
    List<TransactioOutput> ltoi = [];
    interiore.liberTransactions
    .where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.perdita)
    .map((mlt) => mlt.interiore.outputs)
    .forEach(ltoi.addAll);
    if (!ltoi.every((eltoi) => eltoi.publicaClavis == lo.last.probationem)) {
      Print.nota(nuntius: 'pecunia non uritur ante probationem', message: 'money is not burned to previous proof');
      return false;
    }
    BigInt comburantur = BigInt.zero;
    for (TransactioOutput to in lto) {
      comburantur += to.pod;
    }
    BigInt conbusit = BigInt.zero;
    for (TransactioOutput to in ltoi) {
      conbusit += to.pod;
    }
    return comburantur == conbusit;
  }
  Future<bool> armaHabet(List<Obstructionum> lo) async {
    List<String> scuta = 
    await RequiriturInProbationem.requiriturInProbationem(interiore.gladiator.interiore.input!.inimicus.primis, interiore.gladiator.interiore.input!.inimicus.identitatis, Victima(interiore.gladiator.interiore.input!.victima.primis, interiore.gladiator.interiore.input!.victima.identitatis), lo);
    if (scuta.every((s) => probationem.contains(s))) return true;
    return false;
  }

  Future<bool> vicit(List<Obstructionum> lo) async {
    GladiatorInput? gi =
        interiore.gladiator.interiore.input;
    if (gi == null) { 
      Print.nota(
          nuntius: 'Obstructionum gladiatorem sine input',
          message:
              'Block can not have defeaten a gladiator without a gladiator input');
      return false;
    }
    Obstructionum swo = lo.singleWhere((swo) =>
        swo.interiore.gladiator.interiore.identitatis ==
        gi.victima.identitatis);
    String inimicusImpetumBasis = await Pera.turpiaGladiatoriaTelum(
        gi.inimicus.primis, true, gi.inimicus.identitatis, lo);
    List<Telum> inimicusImpetusLiber = await Pera.maximeArma(
        liber: true, primis: gi.inimicus.primis, impetum: true, gladiatorIdentitatis: gi.inimicus.identitatis, lo: lo);
    List<Telum> inimicusImpetusFixum = await Pera.maximeArma(
        liber: false, primis: gi.inimicus.primis, impetum: true, gladiatorIdentitatis: gi.inimicus.identitatis, lo: lo);
    List<String> inimicusImpetus = [inimicusImpetumBasis];
    inimicusImpetusLiber.map((miil) => miil.telum).forEach(inimicusImpetus.addAll);
    inimicusImpetusFixum.map((miif) => miif.telum).forEach(inimicusImpetus.addAll);

    String victimaDefensioBasis = await Pera.turpiaGladiatoriaTelum(
        gi.victima.primis, false, gi.victima.identitatis, lo);
    List<Telum> victimaDefensioLiber = await Pera.maximeArma(
        liber: true, primis: gi.victima.primis, impetum: false, gladiatorIdentitatis: gi.victima.identitatis, lo: lo);
    List<Telum> victimaDefensioFixum = await Pera.maximeArma(
        liber: false, primis: gi.victima.primis, impetum: false, gladiatorIdentitatis: gi.victima.identitatis, lo: lo);
    List<String> victimaDefensiones = [victimaDefensioBasis];
    victimaDefensioLiber
        .map((mvdl) => mvdl.telum)
        .forEach(victimaDefensiones.addAll);
    victimaDefensioFixum
        .map((mvdf) => mvdf.telum)
        .forEach(victimaDefensiones.addAll);
    List<String> requiritur = victimaDefensiones;
    requiritur.removeWhere((rwr) => inimicusImpetus.any((aii) => aii == rwr));
    if (!requiritur.every((er) => probationem.contains(er))) {
      return false;
    }
    List<GladiatorInput?> lgi = [];
    lo
        .map((mo) =>
            mo.interiore.gladiator.interiore.input)
        .forEach(lgi.add);
    if (lgi.any((agi) =>
        agi?.victima.identitatis == gi.victima.identitatis &&
        agi?.victima.primis == gi.victima.primis)) {
      Print.nota(
          nuntius: 'gladiator iam victus est',
          message: 'gladiator is already defeated');
      return false;
    }
    GladiatorOutput go = swo.interiore.gladiator.interiore
        .outputs[gi.victima.primis ? 0 : 1];
    if (!Utils.cognoscereVictusGladiator(
        PublicKey.fromHex(Pera.curve(), interiore.producentis),
        Signature.fromASN1Hex(gi.signature),
        go)) {
      return false;
    }
    return true;
  }
  bool convalidandumTransactions(bool liber, List<Transactio> lt, List<Obstructionum> lo) {
    for (Transactio ft in lt) {
      BigInt totalSpend = BigInt.zero;
      for (TransactioOutput fto in ft.interiore.outputs) {
        totalSpend += fto.pod;
      }
      BigInt allowedToSpend = BigInt.zero;
      for (TransactioInput fti in ft.interiore.inputs) {
        for (Obstructionum o in lo) {
          for (Transactio sft in liber ? o.interiore.liberTransactions : o.interiore.fixumTransactions) {
          
            if (sft.interiore.identitatis == fti.transactioIdentitatis) {
              allowedToSpend += sft.interiore.outputs[fti.index].pod;

            }
          }
        }
      }
      if (totalSpend != allowedToSpend) return false;
    }
    return true;
  }

  bool transactionsIncluduntur(List<Obstructionum> lo, Obstructionum o) {
    Iterable<Obstructionum> io = [...lo, o];
    if (!interiore.liberTransactions.every((lt) => TransactioSignificatio.values.contains(lt.interiore.transactioSignificatio))) return false;
    if (interiore.generare == Generare.efectus && interiore.liberTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.praemium).length != 1) return false;
    if (interiore.generare == Generare.efectus && interiore.liberTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.transform).isNotEmpty) return false;
    if (interiore.generare == Generare.efectus && interiore.fixumTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.transform).isNotEmpty) return false;
    if (interiore.generare == Generare.efectus && interiore.expressiTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.praemium).isNotEmpty) return false;
    if (interiore.generare == Generare.efectus && interiore.expressiTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.transform).isNotEmpty) return false;
    if (interiore.generare == Generare.confussus && interiore.liberTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.praemium).isNotEmpty) return false;
    if (interiore.generare == Generare.expressi && interiore.liberTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.praemium).isNotEmpty) return false;
    if (interiore.generare == Generare.interrumpere && interiore.liberTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.praemium).isNotEmpty) return false;
    if (interiore.generare == Generare.interrumpere && interiore.liberTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.transform).isNotEmpty) return false;
    if (interiore.generare == Generare.interrumpere && interiore.fixumTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.transform).isNotEmpty) return false;
        if (interiore.generare == Generare.interrumpere && interiore.expressiTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.praemium).isNotEmpty) return false;
    if (interiore.generare == Generare.interrumpere && interiore.expressiTransactions.where((x) => x.interiore.transactioSignificatio == TransactioSignificatio.transform).isNotEmpty) return false;
    if (!interiore.fixumTransactions.every((t) => TransactioSignificatio.values.contains(t.interiore.transactioSignificatio))) return false;
    if (interiore.fixumTransactions.where((t) => t.interiore.transactioSignificatio == TransactioSignificatio.praemium).isNotEmpty) return false;
    List<Transactio> llt = o.interiore.liberTransactions.where((lt) => lt.interiore.transactioSignificatio != TransactioSignificatio.praemium && lt.interiore.transactioSignificatio != TransactioSignificatio.transform).toList();  
    if (!convalidandumTransactions(true, llt, io.toList())) return false;
    List<Transactio> lft = o.interiore.fixumTransactions.where((t) => t.interiore.transactioSignificatio != TransactioSignificatio.praemium && t.interiore.transactioSignificatio != TransactioSignificatio.transform).toList();
    if (!convalidandumTransactions(false, lft, io.toList())) return false;
    if (!convalidandumTransactions(true, interiore.expressiTransactions.toList(), io.toList())) return false;
    return true;
  }

  static BigInt confirmationes(List<int> from, List<int> to) {
    if (from.length == to.length) {}
    BigInt counter = BigInt.zero;
    while (to.length != from.length) {
      counter += BigInt.parse(
          ((Constantes.maximeCaudicesFile + 1) - from.last).toString());
      from.add(0);
    }
    counter += BigInt.parse((to.last - from.last).toString());
    return counter;
  }


  // Future<List<SiRemotionemOutput>> inconsumptusRemotionems(
  //     List<Obstructionum> lo) async {
  //   List<SiRemotionem> lsr = [];
  //   lo.map((mo) => mo.interiore.siRemotiones).forEach(lsr.addAll);
  //   List<SiRemotionemOutput?> lsro = [];
  //   lsr
  //       .map((msr) => msr.interioreSiRemotionem.siRemotionemOutput)
  //       .forEach(lsro.add);
  //   List<SiRemotionemInput?> lsri = [];
  //   lsr
  //       .map((msr) => msr.interioreSiRemotionem.siRemotionemInput)
  //       .forEach(lsri.add);
  //   for (SiRemotionemInput? sri in lsri) {
  //     if (sri != null) {
  //       2522222222222 355325222522  35533333333355  53333333333333333333333333333333333333333333333333255 225
  //     }
  //   }
  // }

  static Future removereUltimumObstructionum(Directory directorium) async {
    Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
    if (prioro.interiore.obstructionumNumerus
        .any((aon) => aon == 0)) {
      File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${prioro.interiore.obstructionumNumerus.length - 1}.txt')
          .deleteSync();
    } else {
      File f = File(
          '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${directorium.listSync().length - 1}.txt');
      List<String> os = await Utils.fileAmnis(f).toList();
      os.removeLast();
      f.deleteSync();
      var s = f.openWrite(mode: FileMode.append);
      for (String o in os) {
        s.write('$o\n');
      }
      await s.close();
    }
  }
  // [1] geeft length van 1
  // [1, 1] geeft length van 2
//  setl je voor prior heeft een numerus van [8, 8, 5];
  // en donec heeft een numerus van [5] 
//   
  static Future removereAdProbationemObstructionum(String probationem, Directory directorium) async {
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
    Obstructionum donec = lo.singleWhere((swlo) => swlo.probationem == probationem);
    
    // int donecLength = donec.interiore.obstructionumNumerus.length;
    if (prioro.interiore.obstructionumNumerus.length > donec.interiore.obstructionumNumerus.length) {
      for (int i = prioro.interiore.obstructionumNumerus.length-1; i >= donec.interiore.obstructionumNumerus.length; i--) {
        File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt').deleteSync();
        // prioro.interiore.obstructionumNumerus.removeAt(i);
      }
    }
    File f = File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${directorium.listSync().length - 1}.txt');
    List<String> os = await Utils.fileAmnis(f).toList();
    os.removeRange(donec.interiore.obstructionumNumerus.last+1, os.length);
    f.deleteSync();
    var s = f.openWrite(mode: FileMode.append);
    for (String o in os) {
      s.write('$o\n');
    }
    await s.close();
  }
  
  Future<bool> convalidandumRationibus(List<Obstructionum> lo) async {
    List<Propter> lnp = [];
    interiore.gladiator.interiore.outputs.map((e) => e.rationibus).forEach(lnp.addAll);
    for (Propter p in lnp) {
      if (await Pera.isPublicaClavisDefended(p.interiore.publicaClavis, lo)) {
        Print.nota(nuntius: 'clausus publicas claves iam defendi conatur defendere', message: 'block tries to defend public keys that already are defended');
        return false;
      }
    }
    return true;
  }
  bool badsewapons() {
    if (interiore.defensio.length != 1) return true;
    if (interiore.impetus.length != 50) return true;
    if (interiore.defensio[0].length != 4) return true;
    for (int i = 0; i < interiore.impetus.length; i++) {
      if (interiore.impetus[i].length != 4) return true;
    }
    return false;
  }
  bool convalidandumGenerare() {
    if (!Generare.values.contains(interiore.generare)) return false;
    return true;
  }
  bool convalidandumExpressiMoles() {
    List<Iterable<Transactio>> lllt = [];
    List<String> lltiti = [];
    int counter = 0;
    for (Transactio t in interiore.liberTransactions.toList().reversed.where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.regularis && !lltiti.contains(wlt.interiore.identitatis))) {
      List<Transactio> llt = [];
      llt.add(t);
      lltiti.add(t.interiore.identitatis);
      Transactio? rt = interiore.liberTransactions.singleWhereOrNull((swonlt) => t.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis));
      counter++;
      while (rt != null) {
        counter++;
        llt.add(rt);
        lltiti.add(rt.interiore.identitatis);
        rt = interiore.liberTransactions.singleWhereOrNull((swonlt) => rt!.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis));
      }
      lllt.add(llt.reversed);
    }
    List<TransactioInput> leti = [];
    interiore.expressiTransactions.map((met) => met.interiore.inputs).forEach(leti.addAll);
    
    if (
      counter != interiore.expressiTransactions.length || 
      !leti.every((eeti) => interiore.liberTransactions.map((mlt) => mlt.interiore.identitatis).contains(eeti.transactioIdentitatis) || 
      interiore.expressiTransactions.any((aet) => aet.interiore.identitatis == eeti.transactioIdentitatis))) {
        Print.nota(nuntius: 'transactions expressi possunt solum ad current liber transactions', message: 'expressi transactions may only refer to current liber transactions');
      return false;
    }
    for (List<Transactio> llt in lllt.map((e) => e.toList())) {
      BigInt olpod = BigInt.zero;
      for (TransactioOutput lto in llt.last.interiore.outputs.where((wo) => wo.publicaClavis != llt.last.interiore.dominus)) {
        olpod += lto.pod;
      }
      Transactio? et = interiore.expressiTransactions.singleWhere((wet) => wet.interiore.inputs.any((ai) => ai.transactioIdentitatis == llt.last.interiore.identitatis));
      BigInt oepod = BigInt.zero;
      for (TransactioOutput eto in et.interiore.outputs.where((wo) => wo.publicaClavis != et!.interiore.dominus)) {
        oepod += eto.pod;
      }
      if (olpod != oepod) {
        Print.nota(nuntius: 'expressi transactions amounts ad continet iniuriam', message: 'the expressi transactions contain wrong amounts');
        return false;
      }
      for (int i = llt.length-2; i >= 0; i--) {
        BigInt lpod = BigInt.zero;
        for (TransactioOutput lto in llt[i].interiore.outputs.where((wo) => wo.publicaClavis != llt[i].interiore.dominus)) {
          lpod += lto.pod;
        }
        et = interiore.expressiTransactions.singleWhereOrNull((swonet) => swonet.interiore.inputs.any((ai) => ai.transactioIdentitatis == et!.interiore.identitatis));
        BigInt epod = BigInt.zero; 
        for (TransactioOutput eto in et!.interiore.outputs.where((wo) => wo.publicaClavis != et!.interiore.dominus)) {
          epod += eto.pod;
        }
        if (lpod != epod) {
          Print.nota(nuntius: 'expressi transactions amounts ad continet iniuriam', message: 'the expressi transactions contain wrong amounts');
          return false;
        }
      }
    }
    return true;
  }
  Future<bool> validateDivisia(List<Obstructionum> lo) async {
    List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
    BigInt numerus = await Obstructionum.numeruo(on);
    double divisia = numerus / await Obstructionum.utSummaDifficultas(lo);
    return divisia == interiore.divisa;
  }
  bool txOnlyOnce() {
    List<String> identitatumLiber = [];
    for (Transactio t in interiore.liberTransactions) {
      if (identitatumLiber.contains(t.interiore.identitatis)) return false;
      identitatumLiber.add(t.interiore.identitatis);
    }
    List<String> identitatumFixum = [];
    for (Transactio t in interiore.fixumTransactions) {
      if (identitatumFixum.contains(t.interiore.identitatis)) return false;
      identitatumFixum.add(t.interiore.identitatis);
    }
    List<String> identitatumExpressi = [];
    for (Transactio t in interiore.expressiTransactions) {
      if (identitatumExpressi.contains(t.interiore.identitatis)) return false;
      identitatumExpressi.add(t.interiore.identitatis);
    }
    return true;
  }
  bool longitudoTeliFundamentalis() {
    if (interiore.gladiator.interiore.outputs[0].defensio.length != 4) return false;
    if (interiore.gladiator.interiore.outputs[1].defensio.length != 4) return false;
    if (interiore.gladiator.interiore.outputs[0].impetum.length != 4) return false;
    if (interiore.gladiator.interiore.outputs[0].impetum.length != 4) return false;
    return true;
  }
}
