  import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:hex/hex.dart';
import '../auxiliatores/print.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';
import '../server.dart';
import 'epistulae.dart';
import 'package:encoder/encoder.dart';

class RemoveTransactionsPervideasNuntius extends PervideasNuntius {
  TransactioGenus transactioGenus;
  List<String> identitatum;
  RemoveTransactionsPervideasNuntius(
      this.transactioGenus, this.identitatum, String titulust, List<String> accepit)
      : super(titulust, accepit);
  RemoveTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactioGenus =
            TransactioGenusFromJson.fromJson(nuntius[PervideasNuntiusCasibus.transactioGenus].toString())
                as TransactioGenus,
        identitatum = List<String>.from(
            nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.transactioGenus: transactioGenus.name.toString(),
    PervideasNuntiusCasibus.identitatum: identitatum,
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class RemoveSiRemotionemPervideasNuntius extends PervideasNuntius {
  List<String> signatures;
  RemoveSiRemotionemPervideasNuntius(this.signatures, String titulust, List<String> accepit): super (titulust, accepit);
}

class QueueItem  {
  Socket clientis;
  String msg;
  QueueItem(this.clientis, this.msg);
}

enum Sync {
  novus,
  pergo,
}
class ParAdRimor {
  bool isSalvare = false;
  bool isRemove = false;
  bool isLiber = false;
  bool isBases = false;
  // bool estObstructionum = false;
  // bool scripsit = false;
  bool isEfectusAgit = false;
  bool isConfussusAgit = false;
  bool isExpressiAgit = false;
  int maxPares;
  String ip;
  Directory directorium;
  Random random = Random();
  ReceivePort efectusAcciperePortum = ReceivePort();
  ReceivePort confussusAcciperePortum = ReceivePort();
  ReceivePort expressiAcciperePortum = ReceivePort();
  List<int> summaScandalumNumerus = [];
  Set<String> bases = Set();
  List<Propter> rationibus = [];
  Set<Transactio> liberTransactions = Set();
  Set<Transactio> fixumTransactions = Set();
  Set<Transactio> expressiTransactions = Set();
  Set<InritaTransactio> inritaTransactions = Set();
  Set<SiRemotionem> siRemotiones = Set();
  Set<ConnexaLiberExpressi> connexiaLiberExpressis = Set();
  Set<SolucionisPropter> solucionisRationibus = Set();
  Set<FissileSolucionisPropter> fissileSolucionisRationibus = Set();
  List<Isolate> syncBlocks = [];

  List<QueueItem> epistulae = [];
  bool occupatus = false;
  ParAdRimor(this.maxPares, this.ip, this.directorium);

  audite() async {
    List<String> sip = ip.split(':');
    ServerSocket serverNervum =
        await ServerSocket.bind(InternetAddress.anyIPv4, int.parse(sip[1]));
    serverNervum.listen((clientis) {
      // clientis.setOption(SocketOption.tcpNoDelay, true);
      List<int> buffer = [];
      clientis.listen((data) async {
        buffer.addAll(data);
        while (buffer.contains(0)) {
          int index = buffer.indexOf(0);
          List<int> msgBytes = buffer.sublist(0, index);
          String msg = utf8.decode(msgBytes);
          buffer = buffer.sublist(index + 1);
          PervideasNuntius pn =
            PervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
        
        switch (pn.titulus) {
          case PervideasNuntiusTitulus.connectTaberNodi: {
            UnaBasesSingulasPervideasNuntius ubspn =
              UnaBasesSingulasPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            InConnectPervideasNuntius icpn = InConnectPervideasNuntius(
                bases: bases.toList(),
                rationibus: rationibus,
                liberTansactions: liberTransactions.toList(),
                fixumTransactions: fixumTransactions.toList(),
                expressiTransactions: expressiTransactions.toList(),
                inritaTransactions: inritaTransactions.toList(),
                siRemotionems: siRemotiones.toList(),
                connexaLiberExpressis: connexiaLiberExpressis.toList(),
                solucionisRationibus: solucionisRationibus.toList(),
                fissileSolucionisRationibus: fissileSolucionisRationibus.toList(),
                titulus: PervideasNuntiusTitulus.onConnect,
                accepit: List<String>.from([ip]));
            clientis.write('${json.encode(icpn.indu())}\x00');
            Print.write(icpn.indu());
            await filterOnline();
            List<String> bf = bases.where((wb) => wb != ubspn.nervus && wb != ip && !ubspn.accepit.contains(wb)).toList();
            if (bf.isNotEmpty) {
              String nervuss = bf[random.nextInt(bf.length)];            
              Socket nervus = await Socket.connect(
                  nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              UnaBasesSingulasPervideasNuntius ubspntw = UnaBasesSingulasPervideasNuntius(ubspn.nervus, PervideasNuntiusTitulus.singleSocket, [ip]);             
              nervus.write('${json.encode(ubspntw.indu())}\x00');
            }
            if (bases.length < maxPares &&
              !bases.contains(ubspn.nervus) &&
              ip != ubspn.nervus) {
              bases.add(ubspn.nervus);
            }
            // clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.singleSocket: {
            UnaBasesSingulasPervideasNuntius ubspn =
              UnaBasesSingulasPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            if (bases.length < maxPares && ubspn.nervus != ip) {
              bases.add(ubspn.nervus);
            }
            if (!ubspn.accepit.contains(ip)) {
              ubspn.accepit.add(ip);
            }
            List<String> bf = bases.where((wb) => wb != ip && wb != ubspn.nervus && !ubspn.accepit.contains(wb)).toList();
            if (bf.isNotEmpty) {
              String nervuss = bf[random.nextInt(bf.length)];
              Socket nervus = await Socket.connect(
                    nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write('${json.encode(ubspn.indu())}\x00');
              Print.wroteThrough(ubspn.indu());
            }
            // clientis.destroy();
          }
          case PervideasNuntiusTitulus.petitioObstructionumIncipio: {
            PetitioObstructionumIncipioPervideasNuntius poipn =
              PetitioObstructionumIncipioPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
            if (!poipn.accepit.contains(ip)) {
              poipn.accepit.add(ip);
            }
            clientis.write('${json.encode(ObstructionumReponereUnaPervideasNuntius(
                    remove: null,
                    obstructionum: obss[0],
                    titulus: PervideasNuntiusTitulus.obstructionumReponereUna,
                    accepit: poipn.accepit)
                .indu())}\x00');
            break;
          }
          case PervideasNuntiusTitulus.petitioObstructionum: {
            PetitioObstructionumPervideasNuntius popn =
              PetitioObstructionumPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
            Obstructionum? obs = obss.singleWhereOrNull((element) =>
                element.interiore.priorProbationem ==
                popn.probationem);
            if (obs == null) {
              Obstructionum obsr = await Obstructionum.acciperePrior(directorium);
              clientis.write('${json.encode(SummaScandalumExNodoPervideasNuntius(
                  obsr.interiore.obstructionumNumerus,
                  PervideasNuntiusTitulus.summaScandalumExNodo, []).indu())}\x00');
              // clientis.destroy();
            } else {
              clientis.write('${json.encode(ObstructionumReponereUnaPervideasNuntius(remove: null,
                     obstructionum: obs, titulus: PervideasNuntiusTitulus.obstructionumReponereUna, accepit: [])
                  .indu())}\x00');
            }
            break;
          }
          case PervideasNuntiusTitulus.petitioSockets: {
            // while (isBases) {
            //   await Future.delayed(Duration(seconds: 1));
            // }
            List<String> btr = [];
            PervideasNuntius pn = PervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            for (String nervuss in bases.where((wbases) => wbases != ip)) {
              try {
                await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));        
              } catch (e) {
                btr.add(nervuss);
              }        
            }
            for (String tr in btr) {
              bases.remove(tr);
            }
            clientis.write('${json.encode(RespondBasesPervideasNuntius(bases.toList(), PervideasNuntiusTitulus.respondSockes, [ip]).indu())}\x00');
            break;
          }
          case PervideasNuntiusTitulus.propter: {
            PropterPervideasNuntius ppn = PropterPervideasNuntius.ex(
              json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (await Pera.isPublicaClavisDefended(ppn.propter.interiore.publicaClavis, lo)) {
              Print.nota(nuntius: 'Publica clavis iam defendi', message: 'Public key  already defended');
              break;
            }
            if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), ppn.propter.interiore.publicaClavis), Signature.fromASN1Hex(ppn.propter.interiore.signature), ppn.propter.interiore.publicaClavis)) {
              Print.nota(nuntius: 'verificationem dominii advenientis rationem defendi non potuit', message: 'verification of ownership of the incoming account to be defended failed');
              break;
            }
            if (ppn.propter.probationem ==
                HEX.encode(sha512
                    .convert(utf8.encode(
                        json.encode(ppn.propter.interiore.toJson())))
                    .bytes)) {
              if (rationibus.any((p) =>
                  p.interiore.publicaClavis ==
                  ppn.propter.interiore.publicaClavis)) {
                Propter p = rationibus.singleWhere((swp) => swp.interiore.publicaClavis == ppn.propter.interiore.publicaClavis);
                int zerosOld = 0;
                for (int i = 1; i < p.probationem.length; i++) {
                  if (p.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < ppn.propter.probationem.length; i++) {
                  if (ppn.propter.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  break;
                }
                rationibus.removeWhere((p) =>
                    p.interiore.publicaClavis ==
                    ppn.propter.interiore.publicaClavis);
              }
              rationibus.add(ppn.propter);
              if (!ppn.accepit.contains(ip)) {
                ppn.accepit.add(ip);
              }
              await filterOnline();
              List<String> acceptum = bases.where((wb) => !ppn.accepit.contains(wb)).toList();
              if (acceptum.isEmpty) {
                break;
              }
              String nervuss = acceptum[random.nextInt(acceptum.length)];
              Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              nervus.write('${json.encode(PropterPervideasNuntius(ppn.propter, PervideasNuntiusTitulus.propter, [ip]).indu())}\x00');
              break;
            }
          }
          case PervideasNuntiusTitulus.prepareObstructionumSync: {
            List<String> albumBases = bases.toList();
            albumBases.removeWhere((lb) => pn.accepit.contains(lb));
            clientis.write('${json.encode(PrepareObstructionumAnswerPervideasNuntius(
                albumBases,
                PervideasNuntiusTitulus.prepareObstructionumAnswer, []).indu())}\x00');
            // clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.liberTransactio: {
            LiberTransactioPervideasNuntius ltpn =
              LiberTransactioPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              liberTransactions.removeWhere((t) => HEX.encode(
            sha512.convert(utf8.encode(json.encode(t.interiore.toJson()))).bytes) != t.probationem);
            if (liberTransactions.any((alt) =>
                  alt.interiore.identitatis ==
                  ltpn.transactio.interiore.identitatis)) {
                Transactio lt = liberTransactions.singleWhere((swlt) => swlt.interiore.identitatis == ltpn.transactio.interiore.identitatis);
                int zerosOld = 0;
                for (int i = 1; i < lt.probationem.length; i++) {
                  if (lt.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < ltpn.transactio.probationem.length; i++) {
                  if (ltpn.transactio.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  Print.nota(nuntius: 'non habes ius pro hac re in transactione piscinae', message: 'you do not have the right to replace this transaction in the transaction pool');
                  break;
                }
                liberTransactions.removeWhere((rwlt) =>
                    rwlt.interiore.identitatis ==
                    ltpn.transactio.interiore.identitatis);
              }
              liberTransactions.add(ltpn.transactio);
              // if (!expressiTransactions.any((aet) => aet.interiore.inputs.any((ei) => ei.transactioIdentitatis == ltpn.transactio.interiore.identitatis) && (ltpn.transactio.interiore.transactioSignificatio == TransactioSignificatio.regularis || ltpn.transactio.interiore.transactioSignificatio == TransactioSignificatio.refugium))) {
              //   print('ithinkiwrote');
              //   clientis.write(json.encode(PetitioExpressiTransactioPervideasNuntius(PervideasNuntiusTitulus.petitioExpressiTransactio, pn.accepit).indu()));
              // }
              if (!pn.accepit.contains(ip)) {
                pn.accepit.add(ip);
              }
              syncThrough(TransactioGenus.liber, ltpn.transactio, pn.accepit);
            break;
          }
          case PervideasNuntiusTitulus.fixumTransactio: {
            FixumTransactioPervideasNuntius ftpn =
              FixumTransactioPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              if (fixumTransactions.any((aft) =>
                  aft.interiore.identitatis ==
                  ftpn.transactio.interiore.identitatis)) {
                    
                Transactio lt = fixumTransactions.singleWhere((swlt) => swlt.interiore.identitatis == ftpn.transactio.interiore.identitatis);
                  fixumTransactions.removeWhere((t) => HEX.encode(
                sha512.convert(utf8.encode(json.encode(t.interiore.toJson()))).bytes) != t.probationem);
                int zerosOld = 0;
                for (int i = 1; i < lt.probationem.length; i++) {
                  if (lt.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < ftpn.transactio.probationem.length; i++) {
                  if (ftpn.transactio.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  Print.nota(nuntius: 'non habes ius pro hac re in transactione piscinae', message: 'you do not have the right to replace this transaction in the transaction pool');
                  break;
                }
                fixumTransactions.removeWhere((rwft) =>
                    rwft.interiore.identitatis ==
                    ftpn.transactio.interiore.identitatis);
                  
              }
              if (!fixumTransactions.contains(ftpn.transactio)) fixumTransactions.add(ftpn.transactio);
              if (!pn.accepit.contains(ip)) {
                pn.accepit.add(ip);
              }
              syncThrough(TransactioGenus.fixum, ftpn.transactio, pn.accepit);
              break;
          }
          case PervideasNuntiusTitulus.expressiTransactio: {
            ExpressiTransactioPervideasNuntius etpn =
                ExpressiTransactioPervideasNuntius.ex(
                    json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            List<Transactio> stagnum = [];
            stagnum.addAll(liberTransactions);
            stagnum.addAll(expressiTransactions);

                  fixumTransactions.removeWhere((t) => HEX.encode(
                sha512.convert(utf8.encode(json.encode(t.interiore.toJson()))).bytes) != t.probationem);
              if (expressiTransactions.any((aet) =>
                  aet.interiore.identitatis ==
                  etpn.transactio.interiore.identitatis)) {
                  Transactio tr = expressiTransactions.singleWhere((swet) => swet.interiore.identitatis == etpn.transactio.interiore.identitatis);
                if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), etpn.transactio.interiore.recipiens), Signature.fromASN1Hex(etpn.transactio.interiore.certitudo!), etpn.transactio.interiore.identitatis) && tr.interiore.certitudo == null) {
                  Print.nota(nuntius: 'Missor huius expressi transactionis ius non habuit in reponendo expressi transactionis nostrae', message: 'the sender of this expressi transaction did not have the right to replace our expressi transaction');
                  break;
                }
                expressiTransactions.removeWhere((rwet) =>
                    rwet.interiore.identitatis ==
                    etpn.transactio.interiore.identitatis);
              }
              if (!await convalidandumLiber(stagnum, lo)) break;
              if (!expressiTransactions.contains(etpn.transactio)) expressiTransactions.add(etpn.transactio);
              if (!pn.accepit.contains(ip)) {
                pn.accepit.add(ip);
              }
              syncThrough(TransactioGenus.expressi, etpn.transactio, etpn.accepit);
            break;
          }
          case PervideasNuntiusTitulus.connexaLiberExpressi: {
            ConnexaLiberExpressiPervideasNuntius clepn =
              ConnexaLiberExpressiPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            if (!Utils.cognoscereConnexaLiberExpressi(
                PublicKey.fromHex(Pera.curve(), clepn.cle.dominus),
                Signature.fromASN1Hex(clepn.cle.signature),
                clepn.cle.interioreConnexaLiberExpressi)) {
              Print.nota(
                  nuntius:
                      'solus dominus liber transactionis potest sync an connexionem ad suum expressi transactionem',
                  message:
                      'only the owner of a liber transaction can sync an connection to its expressi transaction');
              return;
            }
            if (!connexiaLiberExpressis.contains(clepn.cle)) connexiaLiberExpressis.add(clepn.cle);
            if (!clepn.accepit.contains(ip)) {
              clepn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !clepn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
              break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(clepn.indu())}\x00');
            break;
          }
          case PervideasNuntiusTitulus.siRemotionem: {
            SiRemotionemPervideasNuntius srpn = SiRemotionemPervideasNuntius.ex(
              json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (srpn.siRemotionem.interiore.siRemotionemInput ==
                null) {
              if (srpn.siRemotionem.validateProbationem() &&
                  srpn.siRemotionem.interiore.cognoscereOutput() &&
                  await srpn.siRemotionem.remotumEst() &&
                  await srpn.siRemotionem.nonHabetInitus() &&
                  srpn.siRemotionem.interiore.siRemotionemOutput!.estTransactionIdentitatisAdhucPraesto(lo, null) &&
                  !inritaTransactions.any((ait) => ait.interiore.identitatis == srpn.siRemotionem.interiore.siRemotionemOutput!.transactioIdentitatis)) {
                await siRemotionemSyncThrough(srpn);
                // clientis.destroy();
              } else {
                Print.nota(
                    nuntius:
                        'si remotionem corruptam accepit',
                    message:
                        'received corrupt si remotionem');
              }
            } else {
              List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              if (
                srpn.siRemotionem.interiore.siRemotionemInput!.cognoscere(lo) && 
              lo.any((ao) => ao.interiore.siRemotiones.any((asr) => asr.interiore.signatureInterioreSiRemotionem == srpn.siRemotionem.interiore .siRemotionemInput!.siRemotionemSignature)) &&
              srpn.siRemotionem.interiore.siRemotionemInput!.solvitStagnum(srpn.siRemotionem.interiore.siRemotionemInput!.interioreTransactio!, lo)
              ) {
                await siRemotionemSyncThrough(srpn);
                // clientis.destroy();

              }
            }
            break;
          }
          case PervideasNuntiusTitulus.removeSiRemotionem: {
            RemoveSiRimotionemRemovePervideasNuntius rsrrpn = RemoveSiRimotionemRemovePervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            if (!par!.siRemotiones.any((asr) => asr.interiore.signatureInterioreSiRemotionem == rsrrpn.srrn.signatureIdentitatis)) {
              Print.nota(nuntius: 'removere conatus si remotionem non habemus', message: 'tried to remove a si remotionem we do not have');
              break;
            }
            SiRemotionem sr = par!.siRemotiones.singleWhere((swsr) => swsr.interiore.signatureInterioreSiRemotionem == rsrrpn.srrn.signatureIdentitatis && swsr.interiore.siRemotionemOutput != null);
            if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), sr.interiore.siRemotionemOutput!.habereIus), Signature.fromASN1Hex(rsrrpn.srrn.signature), sr.interiore.siRemotionemOutput!.transactioIdentitatis)) {
              Print.nota(nuntius: 'verificationem defecit per remotionem si remotionem non poterat cognoscere signature transactionis identitatis ', message: 'verification failed for removal of si remotionem could not verify signature of transaction identity');
              break;
            }
            if (!rsrrpn.accepit.contains(ip)) {
              rsrrpn.accepit.add(ip);
            }
            par!.siRemotiones.remove(sr);
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !rsrrpn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
              break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(rsrrpn.indu())}\x00');
            // nervus.destroy(); 

          }
          case PervideasNuntiusTitulus.solucionisPropter: {
            SolucionisPropterPervideasNuntius sppn = SolucionisPropterPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            solucionisRationibus.removeWhere((s) => HEX.encode(
                sha512.convert(utf8.encode(json.encode(s.interioreSolucionisPropter.toJson()))).bytes) != s.probationem); 
            if (!sppn.solucionisPropter.interioreSolucionisPropter.estValidus(lo) || !sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.nonAccipitEtMittente()) {
              break;
            }
            if (solucionisRationibus.any((asr) => asr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)) {
                SolucionisPropter sp = solucionisRationibus.singleWhere((swsp) => swsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis);
                int zerosOld = 0;
                for (int i = 1; i < sp.probationem.length; i++) {
                  if (sp.probationem.substring(0, i) == ('0' * i)) {
                    zerosOld += 1;
                  }
                }
                int zerosNew = 0;
                for (int i = 1; i < sppn.solucionisPropter.probationem.length; i++) {
                  if (sppn.solucionisPropter.probationem.substring(0, i) == ('0' * i)) {
                    zerosNew += 1;
                  }
                }
                if (zerosNew <= zerosOld) {
                  Print.nota(nuntius: 'non habes ius pro hac solutionis ratione in solutione rationum piscinae', message: 'you do not have the right to replace this pament account n the payment accounts pool');
                  return;
                }
                solucionisRationibus.removeWhere((rwsr) => rwsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sppn.solucionisPropter.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis); 
            }
            solucionisRationibus.add(sppn.solucionisPropter);
            if (!sppn.accepit.contains(ip)) {
              sppn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !sppn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
                break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(sppn.indu())}\x00');
            // nervus.destroy();
            break;
          }
          case PervideasNuntiusTitulus.fissileSolucionisPropter: {
            FissileSolucionisPropterPervideasNuntius fsppn = FissileSolucionisPropterPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            fissileSolucionisRationibus.removeWhere((x) => HEX.encode(
                sha512.convert(utf8.encode(json.encode(x.interioreFissileSolucionisPropter.toJson()))).bytes) != x.probationem);
            if (!fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.estValidus(lo)) {
              break;
            }
            if (!fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.nonAccipitEtMittente()) {
              break;
            }
            if (fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs.isEmpty) {
              Print.nota(nuntius: 'certa pecunia ratio saltem certa', message: 'a fixed payment account should have at least one fixed amount');
              break;
            }
            if (fissileSolucionisRationibus.any((afsr) => afsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)) {
              FissileSolucionisPropter fsp = fissileSolucionisRationibus.singleWhere((swfsp) => swfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis);
              int zerosOld = 0;
              for (int i = 1; i < fsp.probationem.length; i++) {
                if (fsp.probationem.substring(0, i) == ('0' * i)) {
                  zerosOld += 1;
                }
              }
              int zerosNew = 0;
              for (int i = 1; i < fsppn.fissileSolucionisPropter.probationem.length; i++) {
                if (fsppn.fissileSolucionisPropter.probationem.substring(0, i) == ('0' * i)) {
                  zerosNew += 1;
                }
              }
              if (zerosNew <= zerosOld) {
                Print.nota(nuntius: 'non habes ius repone certam solutionis rationem in certa solutione rationum piscinae', message: 'you do not have the right to replace this fixed payment account n the fixed payment accounts pool');
                break;
              }
              fissileSolucionisRationibus.removeWhere((rwsr) => rwsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsppn.fissileSolucionisPropter.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis); 
            }
            if (!fissileSolucionisRationibus.contains(fsppn.fissileSolucionisPropter)) fissileSolucionisRationibus.add(fsppn.fissileSolucionisPropter);
            if (!fsppn.accepit.contains(ip)) {
              fsppn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !fsppn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
              break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(fsppn.indu())}\x00');
            // nervus.destroy();
            break;
          }
          case PervideasNuntiusTitulus.removeConnexaLiberExpressis: {
            RemoveByIdentitatumPervideasNuntius rbipn =
                RemoveByIdentitatumPervideasNuntius.ex(
                    json.decode(msg) as Map<String, dynamic>);
            connexiaLiberExpressis.removeWhere((cle) => rbipn.identitatum.any(
                (identitatis) =>
                    identitatis ==
                    cle.interioreConnexaLiberExpressi.identitatis));
            if (!rbipn.accepit.contains(ip)) {
              rbipn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !rbipn.accepit.contains(ip)).toList();
            if (acceptum.isEmpty) {
              break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(rbipn.indu())}\x00');
            break;
          }
          case PervideasNuntiusTitulus.removePropterStagnum: {
            RemovePropterStagnumPervideasNuntius rpspn = 
            RemovePropterStagnumPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            rationibus.removeWhere((rwrationibus) => rpspn.publicas.any((p) => p == rwrationibus.interiore.publicaClavis));
            if (!rpspn.accepit.contains(ip)) {
              rpspn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !rpspn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
              break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(rpspn.indu())}\x00');
            break;

          }
          case PervideasNuntiusTitulus.removeTransactions: {
            RemoveTransactionsPervideasNuntius rtpn =
                RemoveTransactionsPervideasNuntius.ex(
                    json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            switch (rtpn.transactioGenus) {
              case TransactioGenus.liber: {
                List<String> llti = [];
                lo.map(
                  (mo) => mo.interiore.liberTransactions.map(
                    (mlt) => mlt.interiore.identitatis)).forEach(llti.addAll);
                if (!rtpn.identitatum.every((ei) => llti.contains(ei))) {
                  Print.nota(nuntius: 'transactions non possunt nisi per identitatem eorum removeri, si includuntur in stipitem', message: 'transactions can only be removed by their identity if they are included in a block');
                  break;
                }
                liberTransactions.removeWhere((lt) => rtpn.identitatum.any(
                (identitatis) =>
                    identitatis == lt.interiore.identitatis));
                break;
              }
              case TransactioGenus.fixum: {
                List<String> lfti = [];
                lo.map((mo) => mo.interiore.fixumTransactions.map(
                  (mft) => mft.interiore.identitatis)).forEach(lfti.addAll);
                if (!rtpn.identitatum.every((ei) => lfti.contains(ei))) {
                  Print.nota(nuntius: 'transactions non possunt nisi per identitatem eorum removeri, si includuntur in stipitem', message: 'transactions can only be removed by their identity if they are included in a block');
                  break;
                }
                fixumTransactions.removeWhere((ft) => rtpn.identitatum.any(
                (identitatis) =>
                    identitatis == ft.interiore.identitatis));
                break;
              }
              case TransactioGenus.expressi: {
                List<String> leti = [];
                lo.map((mo) => mo.interiore.expressiTransactions.map(
                  (met) => met.interiore.identitatis)).forEach(leti.addAll);
                if (!rtpn.identitatum.every((ei) => leti.contains(ei))) {
                  Print.nota(nuntius: 'transactions non possunt nisi per identitatem eorum removeri, si includuntur in stipitem', message: 'transactions can only be removed by their identity if they are included in a block');
                  break;
                }
                expressiTransactions.removeWhere((et) => rtpn.identitatum.any(
                (identitatis) =>
                    identitatis == et.interiore.identitatis));
                break;
              }
            }
            if (!rtpn.accepit.contains(ip)) {
                rtpn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !rtpn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
                break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(rtpn.indu())}\x00');
            clientis.destroy();
            break;
          }
          case PervideasNuntiusTitulus.inritaTransactio: {
            InritaTransactioPervideasNuntius itpn = InritaTransactioPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            Transactio? ttr = 
            itpn.interiore.liber ? 
            liberTransactions.singleWhereOrNull(
              (swonlt) => swonlt.interiore.identitatis == itpn.interiore.identitatis) : 
            fixumTransactions.singleWhereOrNull((swonft) => swonft.interiore.identitatis == itpn.interiore.identitatis);
            if (ttr == null) {
              Print.nota(nuntius: 'negotium ad removendum non est inventus', message: 'transaction to remove is not found');
              break;
            }
            if (ttr.interiore.certitudo != null) {
              Print.nota(nuntius: 'non potest removere transactionis quia iam ab ipso signatur', message: 'can not remove transaction because it is already signed by the receiver');
              break;
            }
            if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), ttr.interiore.dominus), Signature.fromASN1Hex(itpn.interiore.signature), ttr.interiore.identitatis)) {
              Print.nota(nuntius: 'nuntius non habet ius removendi rem', message: 'message does not have the right to remove the transaction');
              break;
            }
            itpn.interiore.liber ? liberTransactions.remove(ttr) : fixumTransactions.remove(ttr);
            if (!itpn.accepit.contains(ip)) {
              itpn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !itpn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
                break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(itpn.indu())}\x00');
            break;

          }
          case PervideasNuntiusTitulus.accipreObstructionum: {
            // bool spass = false;
            // while (true) {
            //   while (estObstructionum || scripsit) {
            //     await Future.delayed(Duration(seconds: 1));
            //   }
            //   if (!spass)  {
            //     spass = true;
            //     break;
            //   } 
            // }
            // estObstructionum = true;
            ObstructionumPervideasNuntius opn = ObstructionumPervideasNuntius.ex(
              json.decode(msg) as Map<String, dynamic>);
            Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            List<Obstructionum> foramenFurca = await Obstructionum.getExitusBlocks();
            List<Obstructionum> tridentes = await Obstructionum.getLatusBlocks();
            
            if (opn.obstructionum.interiore.priorProbationem !=
                prioro.probationem) {
              if (!lo.map((mo) => mo.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem) &&
                  !opn.obstructionum.interiore.estFurca) {
                Print.nota(
                    nuntius: 'ignotus obstructionum intra album omnium caudices',
                    message: 'codinside of the list of all blocks');
                break;
              } else if (opn.obstructionum.interiore.estFurca &&
                  foramenFurca.map((mff) => mff.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem)) {
                Obstructionum ffi = foramenFurca.singleWhere((swff) =>
                    swff.probationem ==
                    opn.obstructionum.interiore.priorProbationem);
                do {
                  lo.removeLast();
                } while (lo.last.probationem !=
                    ffi.interiore.priorProbationem);
                lo.add(ffi);
                if (await validateObstructionum(
                    lo, opn.obstructionum)) {
                  reprehendoSummaScandalumNumero(opn.obstructionum);
                  
                  if (opn.obstructionum.interiore.divisa <
                          prioro.interiore.divisa &&
                      opn.obstructionum.interiore
                              .summaObstructionumDifficultas >
                          prioro.interiore
                              .summaObstructionumDifficultas) {
                    await Obstructionum.removereUsqueAd(ffi, directorium);
                    await ffi.salvare(directorium);
                    await opn.obstructionum.salvare(directorium);
                  } else {
                    if (!opn.accepit.contains(ip)) {
                      opn.accepit.add(ip);
                    }
                    await filterOnline();
                    List<String> acceptum = bases.where((wb) => !opn.accepit.contains(wb)).toList();
                    if (acceptum.isNotEmpty) {
                      String nervuss = acceptum[random.nextInt(acceptum.length)];
                      Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                      nervus.write('${json.encode(opn.indu())}\x00');
                    }
                    isSalvare = true;
                    await opn.obstructionum.salvareLatus(directorium);
                    isSalvare = false;
                  }

                  clientis.write('${json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu())}\x00');
                }
                // clientis.destroy();
              } else if (opn.obstructionum.interiore.estFurca &&
                  !foramenFurca.map((mff) => mff.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem)) {
                if (tridentes.map((mt) => mt.probationem).any((ap) =>
                    ap ==
                    opn.obstructionum.interiore.priorProbationem)) {
                  Obstructionum? fton = tridentes.singleWhere((swt) =>
                      swt.probationem ==
                      opn.obstructionum.interiore.priorProbationem);
                  List<Obstructionum> lof = [];
                  do {
                    lof.add(fton!);
                    fton = tridentes.singleWhereOrNull((swt) =>
                        swt.probationem ==
                        fton?.interiore.priorProbationem);
                  } while (fton != null);
                  List<Obstructionum> lov = [];
                  //this conddintion is never true it grabbed al the blocks instead of a couple
                  Obstructionum foramen = foramenFurca.singleWhere((swf) =>
                      swf.probationem ==
                      lof.last.interiore.priorProbationem);
                  lov.addAll(lo.takeWhile((two) =>
                      two.probationem !=
                      foramen.interiore.priorProbationem));
                  lov.add(lo.singleWhere((swo) =>
                      swo.probationem ==
                      foramen.interiore.priorProbationem));
                  lov.add(foramen);
                  lov.addAll(lof.reversed);
                  if (!await validateObstructionum(
                      lov, opn.obstructionum)) {
                    break;
                  }
                  reprehendoSummaScandalumNumero(opn.obstructionum);
                  if (opn.obstructionum.interiore.divisa <
                          prioro.interiore.divisa &&
                      opn.obstructionum.interiore
                              .summaObstructionumDifficultas >
                          prioro.interiore
                              .summaObstructionumDifficultas) {
                    await Obstructionum.removereUsqueAd(foramen, directorium);
                    await foramen.salvare(directorium);
                    for (Obstructionum o in lof.reversed) {
                      await o.salvare(directorium);
                    }
                    await opn.obstructionum.salvare(directorium);
                  }
                  clientis.write('${json.encode(ObstructionumSalvarePervideasNuntius(
                          opn.obstructionum,
                          PervideasNuntiusTitulus.obstructionumIsSalvare,
                          opn.accepit)
                      .indu())}\x00');
                  if (!opn.accepit.contains(ip)) {
                    opn.accepit.add(ip);
                  }
                  await filterOnline();
                  List<String> acceptum = bases.where((wb) => !opn.accepit.contains(wb)).toList();
                  if (acceptum.isNotEmpty) {
                    String nervuss = acceptum[random.nextInt(acceptum.length)];
                    Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                    nervus.write('${json.encode(opn.indu())}\x00');
                  }
                  isSalvare = true;
                  await opn.obstructionum.salvareLatus(directorium);
                  isSalvare = false;
                  // clientis.destroy();
                } else {
                  Print.nota(nuntius: 'nuntius', message: 'invalid fork');
                  break;
                }
              } else if (lo
                      .map((mo) => mo.probationem)
                      .contains(opn.obstructionum.probationem) &&
                  !opn.obstructionum.interiore.estFurca) {
                    
                    List<Obstructionum> loc = lo
                        .takeWhile((two) =>
                            two.interiore.priorProbationem !=
                            opn.obstructionum.probationem)
                        .toList();
                    loc.removeLast();
                    // Obstructionum o = loc.removeLast();
                    if (await validateObstructionum(
                        loc, opn.obstructionum)) {
                        clientis.write('${json.encode(ObstructionumSalvarePervideasNuntius(
                              opn.obstructionum,
                              PervideasNuntiusTitulus.obstructionumIsSalvare,
                              opn.accepit)
                          .indu())}\x00');
                      clientis.destroy();
                    }
                    break;
              } else if (lo.map((mo) => mo.probationem).contains(opn
                      .obstructionum.interiore.priorProbationem) &&
                  !opn.obstructionum.interiore.estFurca) {
                List<Obstructionum> lov = [];
                lov.addAll(lo.takeWhile((two) =>
                    two.probationem !=
                    opn.obstructionum.interiore.priorProbationem));
                lov.add(lo.singleWhere((swo) =>
                    swo.probationem ==
                    opn.obstructionum.interiore.priorProbationem));
                    //besides shouldnt we only validate the divisa instead of both divisa and summa difficulates
                if (await validateObstructionum(
                    lov, opn.obstructionum)) {
                  if (opn.obstructionum.interiore.divisa <
                          prioro.interiore.divisa &&
                      opn.obstructionum.interiore
                              .summaObstructionumDifficultas >
                          prioro.interiore
                              .summaObstructionumDifficultas) {
                    await Obstructionum.removereUsqueAd(
                        opn.obstructionum, directorium);
                    reprehendoSummaScandalumNumero(opn.obstructionum);
                    isSalvare = true;
                    await opn.obstructionum.salvare(directorium);
                    isSalvare = false;
                  } else {
                     // this block is saved against the rule so maby we could improve our code at some locations to save like this too without validation on the other node 
                    clientis.write('${json.encode(ObstructionumSalvarePervideasNuntius(
                      opn.obstructionum,
                      PervideasNuntiusTitulus.obstructionumIsSalvare,
                      opn.accepit)
                    .indu())}\x00');
                    if (!opn.accepit.contains(ip)) {
                      opn.accepit.add(ip);
                    }
                    await filterOnline();
                    List<String> acceptum = bases.where((wb) => !opn.accepit.contains(wb)).toList();
                    if (acceptum.isNotEmpty) {
                      String nervuss = acceptum[random.nextInt(acceptum.length)];
                      Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                      nervus.write('${json.encode(opn.indu())}\x00');
                    }
                    isSalvare = true;
                    await opn.obstructionum.salvareExitus(directorium);
                    isSalvare = false;
                  }
                 // clientis.destroy();
                }
              } else {
                List<Obstructionum> loc = lo
                    .takeWhile((fwo) =>
                        fwo.probationem ==
                        opn.obstructionum.interiore.priorProbationem)
                    .toList();
                loc.add(lo.singleWhere((swo) =>
                    loc.last.probationem ==
                    swo.interiore.priorProbationem));

                if (!await validateObstructionum(
                    loc, opn.obstructionum)) {
                  break;
                }
                reprehendoSummaScandalumNumero(opn.obstructionum);
                isSalvare = true;
                opn.obstructionum.salvareExitus(directorium);
                if (!opn.accepit.contains(ip)) {
                  opn.accepit.add(ip);
                }
                for (String nervuss
                    in bases.where((wb) => !opn.accepit.contains(wb))) {
                  Socket nervus = await Socket.connect(
                      nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                  nervus.write('${json.encode(
                      SatusFurcaPropagationemPervideasNuntius(
                              opn.obstructionum,
                              PervideasNuntiusTitulus.addereForamenFurca,
                              opn.accepit)
                          .indu())}\x00');
                }
              }
            } else if (opn.obstructionum.interiore.estFurca) {
              if (opn.obstructionum.interiore.obstructionumNumerus.length > summaScandalumNumerus.length) {
                clientis.write('${json.encode(InvalidumFurcaPervideasNuntius(PervideasNuntiusTitulus.invalidumFurca, [ip]).indu())}\x00');
                break;
              } else if (opn.obstructionum.interiore.obstructionumNumerus.length == summaScandalumNumerus.length) {
                if (opn.obstructionum.interiore.obstructionumNumerus.last > summaScandalumNumerus.last) {
                  clientis.write('${json.encode(InvalidumFurcaPervideasNuntius(PervideasNuntiusTitulus.invalidumFurca, [ip]).indu())}\x00');
                  break;
                } 
              }
              isSalvare = true;
              await opn.obstructionum.salvare(directorium);
              isSalvare = false;

            } else {
              
              if (!await validateObstructionum(lo, opn.obstructionum)) {
                break;
              }
              clientis.write('${json.encode(ObstructionumSalvarePervideasNuntius(
                      opn.obstructionum,
                      PervideasNuntiusTitulus.obstructionumIsSalvare,
                      opn.accepit)
                  .indu())}\x00');
              if (!opn.accepit.contains(ip)) {
                opn.accepit.add(ip);
              }
              await filterOnline();
              List<String> acceptum = bases.where((wbases) => !opn.accepit.contains(wbases)).toList();
              if (acceptum.isNotEmpty) {
                String nervuss = acceptum[random.nextInt(acceptum.length)];
                Socket nervus = await Socket.connect(
                    nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                nervus.write('${json.encode(ObstructionumPervideasNuntius(
                        opn.obstructionum,
                        PervideasNuntiusTitulus.accipreObstructionum,
                        opn.accepit)
                    .indu())}\x00');
              }
              isSalvare = true;
              await opn.obstructionum.salvare(directorium);               
              isSalvare = false;
              Print.nota(nuntius: "nuntius", message: "received new bock with number ${opn.obstructionum.interiore.obstructionumNumerus} ");

              // List<String> lbu = bases.where((wb) => wb != ip && !opn.accepit.contains(wb)).toList();
              // print('soweirdlbu $lbu');
              // reprehendoSummaScandalumNumero(opn.obstructionum);
              // if (lbu.isNotEmpty) {
              //   String nervuss = lbu[random.nextInt(lbu.length)];
              //   Socket nervus = await Socket.connect(
              //       nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              //   print('choserandom $nervuss');
              //   nervus.write(json.encode(ObstructionumPervideasNuntius(
              //           opn.obstructionum,
              //           PervideasNuntiusTitulus.accipreObstructionum,
              //           opn.accepit)
              //       .indu()));
              //   nervus.listen((convalescit) async {
              //     print('tellmethiswasdouble 1');
              //     ObstructionumSalvarePervideasNuntius ospn =
              //         ObstructionumSalvarePervideasNuntius.ex(
              //             json.decode(String.fromCharCodes(convalescit).trim())
              //                 as Map<String, dynamic>);
              //     print('listenedtoresponse \n ${ospn.indu()}');
              //     Obstructionum prior = await Obstructionum.acciperePrior(directorium);
              //     isSalvare = true;
              //     await ospn.obstructionum.salvare(directorium);
              //     isSalvare = false;
              //     removerePropterNovumObstructionum(prior, ospn.obstructionum);
              //   });
              // } else {
              //   List<String> jo = bases.where((wb) => wb != ip).toList();
              //   String nervuss = jo[random.nextInt(jo.length)];
              //   Socket nervus = await Socket.connect(
              //       nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
              //   nervus.write(json.encode(ObstructionumPervideasNuntius(opn.obstructionum, PervideasNuntiusTitulus.accipreObstructionum, opn.accepit).indu()));
              //   nervus.listen((convalescit) async {
              //     print('tellmewasthisdouble');
              //     ObstructionumSalvarePervideasNuntius ospn =
              //         ObstructionumSalvarePervideasNuntius.ex(
              //             json.decode(String.fromCharCodes(convalescit).trim())
              //                 as Map<String, dynamic>);
              //     print('listenedtoresponse \n ${ospn.indu()}');
              //     Obstructionum prior = await Obstructionum.acciperePrior(directorium);
              //     // if (ospn.obstructionum.interiore.priorProbationem == prior.probationem) {
              //       isSalvare = true;
              //       await ospn.obstructionum.salvare(directorium);
              //       isSalvare = false;
              //       removerePropterNovumObstructionum(prior, ospn.obstructionum);
              //     // }
              //   });

              //   // ja je kunt hier alsnog een andere node het werk laten doen.

              //   // isSalvare = true;
              //   // await opn.obstructionum.salvare(directorium);
              //   // isSalvare = false;
              //   // removerePropterNovumObstructionum(prior, novus)
              // }

            }
            // estObstructionum = false;
            break;
          } 
          case PervideasNuntiusTitulus.addereForamenFurca: {
            SatusFurcaPropagationemPervideasNuntius sfppn =
              SatusFurcaPropagationemPervideasNuntius.ex(
                  json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
            if (!lo
                .map((mo) => mo.probationem)
                .contains(sfppn.obstructionum.probationem)) {
              Print.nota(
                  nuntius: 'non iure primo de furca',
                  message: 'not a legal begin of a fork');
              break;
            }
            isSalvare = true;
            await sfppn.obstructionum.salvareExitus(directorium);
            isSalvare = false;
            if (!sfppn.accepit.contains(ip)) {
              sfppn.accepit.add(ip);
            }
            await filterOnline();
            List<String> acceptum = bases.where((wbases) => !sfppn.accepit.contains(wbases)).toList();
            if (acceptum.isEmpty) {
              break;
            }
            String nervuss = acceptum[random.nextInt(acceptum.length)];
            Socket nervus = await Socket.connect(
              nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
            nervus.write('${json.encode(SatusFurcaPropagationemPervideasNuntius(
                sfppn.obstructionum,
                PervideasNuntiusTitulus.addereForamenFurca,
                sfppn.accepit).indu())}\x00');
            break;
          }
          case PervideasNuntiusTitulus.posseSyncFurca: {
            PosseSyncFurcaPervideasNuntius psfpn = PosseSyncFurcaPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            List<Obstructionum> lop = await Obstructionum.getBlocks(directorium);
            if (lop.any((alop) => alop.probationem == psfpn.summum)) {
                Obstructionum ralop = lop.removeLast();
                while (ralop.interiore.estFurca == true) {
                  ralop = lop.removeLast();
                }
                clientis.write('${json.encode(ObstructionumReponereUnaPervideasNuntius(remove: true, obstructionum: ralop, titulus: PervideasNuntiusTitulus.obstructionumReponereUna, accepit: [ip]).indu())}\x00');
            } else if (!lop.any((alop) => alop.probationem == psfpn.summum)) {
                clientis.write('${json.encode(DeclinareFurcaPervideasNuntius(bases.toList(), PervideasNuntiusTitulus.declinareFurca, [ip]).indu())}\x00');
            } 
          }
        }
          
        }
      });
      });
  }

  void connect(String taberNodi) async {
    bases.add(taberNodi);
    List<String> taberNodifissile = taberNodi.split(':');
    Socket nervus = await Socket.connect(
        taberNodifissile[0], int.parse(taberNodifissile[1]));
    nervus.write('${json.encode(UnaBasesSingulasPervideasNuntius(
            ip, PervideasNuntiusTitulus.connectTaberNodi, [])
        .indu())}\x00');
    List<int> buffer = [];
    nervus.listen((data) async {
      buffer
      .addAll(data);
      while (buffer.contains(0)) {
          int index = buffer.indexOf(0);
          List<int> msgBytes = buffer.sublist(0, index);
          String d = utf8.decode(msgBytes);              
          buffer = buffer.sublist(index + 1);
          InConnectPervideasNuntius icpn = InConnectPervideasNuntius.ex(json.decode(d) as Map<String, dynamic>);
          if (bases.length < maxPares) {
            if (bases.contains(ip)) {
              bases.remove(ip);
            }
            bases.addAll(icpn.bases.where((wb) => wb != ip).take((maxPares - bases.length)));
          }
          rationibus.addAll(icpn.rationibus);
          liberTransactions.addAll(icpn.liberTansactions);
          fixumTransactions.addAll(icpn.fixumTransactions);
          expressiTransactions.addAll(icpn.expressiTransactions);
          
        }
    }, onDone: () => nervus.destroy());
  }

  void sync({ required Sync sync }) async {
    switch (sync) {
      case Sync.novus: {
        String nervuss = bases.toList()[random.nextInt(bases.length)];
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(PetitioObstructionumIncipioPervideasNuntius(
            PervideasNuntiusTitulus.petitioObstructionumIncipio, [ip]).indu())}\x00');
        List<int> buffer = [];
        nervus.listen((eventus) async {
          buffer.addAll(eventus);
          while (buffer.contains(0)) {
            int index = buffer.indexOf(0);
            List<int> msgBytes = buffer.sublist(0, index);
            String d = utf8.decode(msgBytes);
            buffer = buffer.sublist(index + 1);
                      PervideasNuntius pn = PervideasNuntius.ex(
              json.decode(d) as Map<String, dynamic>);
          if (pn.titulus == PervideasNuntiusTitulus.obstructionumReponereUna) {
            ObstructionumReponereUnaPervideasNuntius orupn =
                ObstructionumReponereUnaPervideasNuntius.ex(
                    json.decode(d)
                        as Map<String, dynamic>);
            
            if (orupn.obstructionum.interiore.generare ==
                Generare.incipio) {
              await orupn.obstructionum.salvareIncipio(directorium);
              Print.nota(nuntius: "incipio synchronizatus", message: 'synced incipio block');
              nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(
                  orupn.obstructionum.probationem,
                  PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
            } else {
              List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              if (!await validateObstructionum(lo, orupn.obstructionum)) {
                Print.nota(nuntius: 'nuntius', message: 'synced corrupt block stopped syncing');
                return;
              }
              await orupn.obstructionum.salvare(directorium);
              Print.nota(nuntius: 'numerus segmenti synchronizati ${orupn.obstructionum.interiore.obstructionumNumerus}', message: 'synced block number ${orupn.obstructionum.interiore.obstructionumNumerus}');
              nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(
                  orupn.obstructionum.probationem,
                  PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
            }
          } else if (pn.titulus == PervideasNuntiusTitulus.summaScandalumExNodo) {
            SummaScandalumExNodoPervideasNuntius scenpn =
                SummaScandalumExNodoPervideasNuntius.ex(
                    json.decode(d)
                        as Map<String, dynamic>);
            Print.nota(
                nuntius:
                    'ad summum impedimentum perveneris cum numero ${scenpn.numerus} nodi hodiernae adhuc sync ulteriore si novus clausus additur catenae',
                message:
                    'you have reached the highest block with number ${scenpn.numerus} the current node you will still sync further if a new block is added to the chain');
          }
          }
        });
        break;
      }
      case Sync.pergo: {
        Obstructionum prior = await Obstructionum.acciperePrior(directorium);
        String nervuss = bases.toList()[random.nextInt(bases.length)];
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(prior.probationem,
            PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
        List<int> buffer = [];
        nervus.listen((eventus) async {
          buffer.addAll(eventus);
          while (buffer.contains(0)) {
            int index = buffer.indexOf(0);
            List<int> msgBytes = buffer.sublist(0, index);
            buffer = buffer.sublist(index + 1);
            String d = utf8.decode(msgBytes);
          PervideasNuntius pn = PervideasNuntius.ex(
              json.decode(d) as Map<String, dynamic>);
          switch(pn.titulus) {
            case PervideasNuntiusTitulus.summaScandalumExNodo: {
              SummaScandalumExNodoPervideasNuntius scenpn =
                SummaScandalumExNodoPervideasNuntius.ex(
                    json.decode(d)
                        as Map<String, dynamic>);
              Print.nota(
                  nuntius:
                      '',
                  message:
                      'if your blocknumber was lower than ${scenpn.numerus} you have reached it, otherwise you could not sync');
              break;
            }
            case PervideasNuntiusTitulus.obstructionumReponereUna: {
              ObstructionumReponereUnaPervideasNuntius orupn =
              ObstructionumReponereUnaPervideasNuntius.ex(
                  json.decode(d)
                      as Map<String, dynamic>);
              List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
              if (!await validateObstructionum(lo, orupn.obstructionum)) {
                Print.nota(nuntius: 'nuntius', message: 'corrupt block in sync stopped syncing');
                return;
              }
              isSalvare = true;
              await orupn.obstructionum.salvare(directorium);
              isSalvare = false;
              Print.nota(nuntius: 'numerus segmenti synchronizati ${orupn.obstructionum.interiore.obstructionumNumerus}', message: 'synced block number ${orupn.obstructionum.interiore.obstructionumNumerus}');
              nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(
                  orupn.obstructionum.probationem,
                  PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
                  List<int> b = [];
            }
          }
          }
        });
        break;
      }

    }
  }
  Future filterOnline() async {
    List<String> btr = [];
    for (String nervuss in bases.where((wbases) => wbases != ip)) {
      try {
        await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));        
      } catch (e) {
        btr.add(nervuss);
      }
    }
    for (String tr in btr) {
      bases.remove(tr);
    }
    if (bases.isEmpty) {
      return;
    }
    String nervuss = bases.toList()[random.nextInt(bases.length)];
    Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(PervideasNuntius(PervideasNuntiusTitulus.petitioSockets, [ip]).indu())}\x00');
    List<int> buffer = [];
    nervus.listen((nuntius) { 
      buffer.addAll(nuntius);
      while (buffer.contains(0)) {
        int index = buffer.indexOf(0);
        List<int> msgBytes = buffer.sublist(0, index);
        buffer = buffer.sublist(index + 1);
        String c = utf8.decode(msgBytes);
        RespondBasesPervideasNuntius rbpn = RespondBasesPervideasNuntius.ex(json.decode(c) as Map<String, dynamic>);
        for (String base in rbpn.bases) {
          if (!bases.contains(base) && maxPares > bases.length && base != ip) {
            bases.add(base);
          }
        }
      }
    }, onDone: () => nervus.destroy());
  }

  Future syncPropter(Propter propter) async {
    if (rationibus.any((p) =>
      p.interiore.publicaClavis ==
      propter.interiore.publicaClavis)) {
        rationibus.removeWhere((p) =>
            p.interiore.publicaClavis ==
            propter.interiore.publicaClavis);
    }
    rationibus.add(propter);
    await filterOnline();
    List<String> conatus = [];
      List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
      
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(PropterPervideasNuntius(propter, PervideasNuntiusTitulus.propter, [ip]).indu())}\x00');
        nervus.destroy();
    
  }

  Future syncLiberTransaction(Transactio ltx) async {
    if (liberTransactions.any((alt) =>
        alt.interiore.identitatis ==
        ltx.interiore.identitatis)) {
      liberTransactions.removeWhere((rwlt) =>
          rwlt.interiore.identitatis ==
          ltx.interiore.identitatis);
    }
    liberTransactions.add(ltx);
    await filterOnline();
    List<String> conatus = [];
    
        List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();

        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(TransactioPervideasNuntius(
          ltx, PervideasNuntiusTitulus.liberTransactio, [ip]).indu())}\x00');
        nervus.destroy();        
    
    
  }

  Future syncFixumTransaction(Transactio tx) async {
    if (fixumTransactions.any((t) =>
        t.interiore.identitatis ==
        tx.interiore.identitatis)) {
      fixumTransactions.removeWhere((t) =>
          t.interiore.identitatis ==
          tx.interiore.identitatis);
    }
    fixumTransactions.add(tx);
    await filterOnline();
        String nervuss = bases.toList()[random.nextInt(bases.length)];
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(TransactioPervideasNuntius(
          tx, PervideasNuntiusTitulus.fixumTransactio, [ip]).indu())}\x00');
        nervus.destroy();
    
  }

  Future syncExpressiTransaction(Transactio tx) async {
    if (expressiTransactions.any((t) =>
        t.interiore.identitatis ==
        tx.interiore.identitatis)) {
      expressiTransactions.removeWhere((t) =>
          t.interiore.identitatis ==
          tx.interiore.identitatis);
    }
    expressiTransactions.add(tx);
    await filterOnline();
    List<String> conatus = [];
      List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
      
      String nervuss = acceptum[random.nextInt(acceptum.length)];
      conatus.add(nervuss);
      Socket nervus = await Socket.connect(
        nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write('${json.encode(TransactioPervideasNuntius(
        tx, PervideasNuntiusCasibus.expressiTransactio, [ip]).indu())}\x00');
      nervus.destroy();
    
  }

  Future syncInritaTransaction(InritaTransactio it) async {
    if (inritaTransactions.any((ait) => ait.interiore.identitatis == it.interiore.identitatis)) {
      inritaTransactions.removeWhere((rwit) => rwit.interiore.identitatis == it.interiore.identitatis);
    }
    inritaTransactions.add(it);
    await filterOnline();
    List<String> conatus = [];
      List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
        
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(InritaTransactioPervideasNuntius(it.interiore, PervideasNuntiusTitulus.inritaTransactio, [ip]).indu())}\x00');
        nervus.destroy();      
  }
  // maby avoid checking just check if any and skippi syncing if already is in the list
  Future syncConnexaLiberExpressi(ConnexaLiberExpressi clep) async {
    connexiaLiberExpressis.add(clep);
    await filterOnline();
    List<String> conatus = [];
        List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
        
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(ConnexaLiberExpressiPervideasNuntius(
          clep, PervideasNuntiusTitulus.connexaLiberExpressi, [ip]).indu())}\x00');
        nervus.destroy();
       
    
  }

  Future syncSiRemotiones(SiRemotionem sr) async {
    if (siRemotiones.any((asr) =>
        asr.interiore.signatureInterioreSiRemotionem ==
        sr.interiore.signatureInterioreSiRemotionem)) {
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interiore.signatureInterioreSiRemotionem ==
          sr.interiore.signatureInterioreSiRemotionem);
    }
    siRemotiones.add(sr);
    await filterOnline();
    List<String> conatus = [];
  
        List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(SiRemotionemPervideasNuntius(
          sr, PervideasNuntiusTitulus.siRemotionem, [ip]).indu())}\x00');
        nervus.destroy();
  } 

  Future syncSolucionisPropter(SolucionisPropter sr) async {
    if (solucionisRationibus.any((asr) => asr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)) {
      solucionisRationibus.removeWhere((rwsr) => rwsr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == sr.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis);
    }
    solucionisRationibus.add(sr);
    await filterOnline();
    List<String> conatus = [];
    
        List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
    
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(SolucionisPropterPervideasNuntius(
          sr, PervideasNuntiusTitulus.solucionisPropter, [ip]).indu())}\x00');
        nervus.destroy();
      
    
  }
  Future syncFissileSolucionisPropter(FissileSolucionisPropter fsr) async {
    if (fissileSolucionisRationibus.any((afsr) => afsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)) {
      fissileSolucionisRationibus.removeWhere((rwfsr) => rwfsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == fsr.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis);
    }
    fissileSolucionisRationibus.add(fsr);
    await filterOnline();
    List<String> conatus = [];
    List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
   
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    conatus.add(nervuss);
    Socket nervus = await Socket.connect(
        nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(FissileSolucionisPropterPervideasNuntius(
      fsr, PervideasNuntiusTitulus.fissileSolucionisPropter, [ip]).indu())}\x00');
    nervus.destroy();
  }
  
  Future syncFurca(String summum) async {
    ReceivePort rp = ReceivePort();
    List<String> conatus = [];
    List<String> extra = [];
    String nervuss = bases.toList()[random.nextInt(bases.length)];
    Socket nervus = await Socket.connect(
      nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(PosseSyncFurcaPervideasNuntius(summum, PervideasNuntiusTitulus.posseSyncFurca, [ip]).indu())}\x00');
    List<int> buffer = [];
    nervus.listen((eventus) async { 
      buffer.addAll(eventus);
      while (buffer.contains(0)) {
        int index = buffer.indexOf(0);
        List<int> msgBytes = buffer.sublist(0, index);
        buffer = buffer.sublist(index + 1);
        String msg = utf8.decode(msgBytes);
        PervideasNuntius pn = PervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
        switch (pn.titulus) {
          case PervideasNuntiusTitulus.obstructionumReponereUna: {
            ObstructionumReponereUnaPervideasNuntius orupn = ObstructionumReponereUnaPervideasNuntius.ex(json.decode(msg));
            if (orupn.remove == true) {
              await Obstructionum.removereAdProbationemObstructionum(orupn.obstructionum.interiore.priorProbationem, directorium);
            }
            Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
            if (orupn.obstructionum.interiore.priorProbationem == prioro.probationem) {
              isSalvare = true;
              await orupn.obstructionum.salvare(directorium);
              isSalvare = false;
              nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
              PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
            }
            break;
          }
          case PervideasNuntiusTitulus.declinareFurca: {
            DeclinareFurcaPervideasNuntius dfpn = DeclinareFurcaPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            conatus.add(nervuss);
            extra.addAll(dfpn.lymphaticorum);
            rp.sendPort.send(nervuss);
            break;
          }
          case PervideasNuntiusTitulus.summaScandalumExNodo: {
            SummaScandalumExNodoPervideasNuntius scenpn =
              SummaScandalumExNodoPervideasNuntius.ex(
                  json.decode(msg)
                      as Map<String, dynamic>);
            Print.nota(
                nuntius:
                    'ad summum impedimentum perveneris cum numero ${scenpn.numerus} nodi hodiernae adhuc sync ulteriore si novus clausus additur catenae',
                message:
                    'you have reached the highest block with number ${scenpn.numerus} the current node you will still sync further if a new block is added to the chain');
            break;
          }
        }
      }


    }, onDone: () => nervus.destroy());
    rp.listen((message) async {
      List<String> basesEarumExtra = bases.where((wb) => !conatus.contains(wb)).toList();
      basesEarumExtra.addAll(extra.where((we) => !conatus.contains(we)));
      String nervuss = basesEarumExtra[random.nextInt(basesEarumExtra.length)];
      Socket nervus = await Socket.connect(
      nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
      nervus.write('${json.encode(PosseSyncFurcaPervideasNuntius(summum, PervideasNuntiusTitulus.posseSyncFurca, [ip]).indu())}\x00');
      List<int> buffer = [];
      nervus.listen((eventus) async { 
        buffer.addAll(eventus);
        while (buffer.contains(0)) {
          int index = buffer.indexOf(0);
          List<int> msgBytes = buffer.sublist(0, index);
          buffer = buffer.sublist(index + 1);
          String msg = utf8.decode(msgBytes);
                  PervideasNuntius pn = PervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
        switch (pn.titulus) {
          case PervideasNuntiusTitulus.obstructionumReponereUna: {
            ObstructionumReponereUnaPervideasNuntius orupn = ObstructionumReponereUnaPervideasNuntius.ex(json.decode(msg) as Map<String, dynamic>);
            if (orupn.remove == true) {
              await Obstructionum.removereAdProbationemObstructionum(orupn.obstructionum.interiore.priorProbationem, directorium);
            }
            Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
            // Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
            if (orupn.obstructionum.interiore.priorProbationem == prioro.probationem) {
              isSalvare = true;
              await orupn.obstructionum.salvare(directorium);
              isSalvare = false;
              nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(
                orupn.obstructionum.probationem,
              PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
            }
            break;
          }
          case PervideasNuntiusTitulus.declinareFurca: {
            conatus.add(nervuss);
            rp.sendPort.send(null);
            break;
          }
          case PervideasNuntiusTitulus.summaScandalumExNodo: {
            SummaScandalumExNodoPervideasNuntius scenpn =
              SummaScandalumExNodoPervideasNuntius.ex(
                  json.decode(msg)
                      as Map<String, dynamic>);
            Print.nota(
                nuntius:
                    'ad summum impedimentum perveneris cum numero ${scenpn.numerus} nodi hodiernae adhuc sync ulteriore si novus clausus additur catenae',
                message:
                    'you have reached the highest block with number ${scenpn.numerus} the current node you will still sync further if a new block is added to the chain');
            break;
          }
        }
        }

      }, onDone: () => nervus.destroy());
    });
  }

  Future removePropterStagnum(List<String> publicas) async {
    rationibus.removeWhere((rwrationibus) => publicas.any((p) => p == rwrationibus.interiore.publicaClavis));
    await filterOnline();
    List<String> conatus = [];
    
        List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
            nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(RemovePropterStagnumPervideasNuntius(publicas, PervideasNuntiusTitulus.removePropterStagnum, [ip]).indu())}\x00');
        nervus.destroy();
  }
  // proof you are the owner
  Future removeExpressiTransactions(List<String> identitatum) async {
    expressiTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interiore.identitatis));
    await filterOnline();
    List<String> acceptum = bases.where((wbases) => wbases != ip).toList();
    if (acceptum.isEmpty) {
      return;
    }
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    Socket nervus = await Socket.connect(
        nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(RemoveTransactionsPervideasNuntius(
          TransactioGenus.expressi,
          identitatum,
          PervideasNuntiusTitulus.removeTransactions,
          [ip]).indu())}\x00');
      nervus.destroy();
  }
  Future removeLiberTransactions(List<String> identitatum) async {
    liberTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interiore.identitatis));
    await filterOnline();
    List<String> acceptum = bases.where((wbases) => wbases != ip).toList();
    if (acceptum.isEmpty) {
      return;
    }
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    Socket nervus = await Socket.connect(
        nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(RemoveTransactionsPervideasNuntius(
          TransactioGenus.liber,
          identitatum,
          PervideasNuntiusTitulus.removeTransactions,
          [ip]).indu())}\x00');
      nervus.destroy();
  }
  Future removeFixumTransactions(List<String> identitatum) async {
    fixumTransactions.removeWhere(
        (l) => identitatum.any((i) => i == l.interiore.identitatis));
    await filterOnline();
    List<String> acceptum = bases.where((wbases) => wbases != ip).toList();
    if (acceptum.isEmpty) {
      return;
    }
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    Socket nervus = await Socket.connect(
        nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(RemoveTransactionsPervideasNuntius(
          TransactioGenus.fixum,
          identitatum,
          PervideasNuntiusTitulus.removeTransactions,
          [ip]).indu())}\x00');
     nervus.destroy();
  }
  // Future removeSiRemotionems(List<String> signatures) async {
  //   siRemotiones.removeWhere((s) => signatures.any((si) => si == s.interiore.signatureInterioreSiRemotionem) || signatures.any((sii) => sii == s.interiore.siRemotionemInput?.siRemotionemSignature));
  //   await filterOnline();
  //   List<String> acceptum = bases.where((wbases) => wbases != ip).toList();
  //   if (acceptum.isEmpty) {
  //     return;
  //   }
  //   String nervuss = acceptum[random.nextInt(acceptum.length)];
  //   Socket nervus = await Socket.connect(
  //       nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    
  // }
  // proof you are the owner too
  Future removeConnexaLiberExpressis(List<String> identitatum) async {
    connexiaLiberExpressis.removeWhere((cle) => identitatum.any((identitatis) =>
        identitatis == cle.interioreConnexaLiberExpressi.identitatis));
    await filterOnline();
    List<String> acceptum = bases.where((wbases) => wbases != ip).toList();
    if (acceptum.isEmpty) {
      return;
    }
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    Socket nervus = await Socket.connect(
        nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
    nervus.write('${json.encode(RemoveByIdentitatumPervideasNuntius(
      identitatum,
      PervideasNuntiusTitulus.removeConnexaLiberExpressis,
      [ip]).indu())}\x00');
    nervus.destroy();
  }

  Future removeSiRemotionem(SiRemotionemRemoveNuntius srrn) async {
    if (siRemotiones.any((asr) => asr.interiore.signatureInterioreSiRemotionem == srrn.signatureIdentitatis)) {
          siRemotiones.removeWhere((rwsr) => rwsr.interiore.signatureInterioreSiRemotionem == srrn.signatureIdentitatis);
          await filterOnline();
          List<String> conatus = [];
            List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
              String nervuss = acceptum[random.nextInt(acceptum.length)];
              conatus.add(nervuss);
              Socket nervus = await Socket.connect(
                nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
                nervus.write('${json.encode(RemoveSiRimotionemRemovePervideasNuntius(srrn, PervideasNuntiusTitulus.removeSiRemotionem, [ip]).indu())}\x00');
              nervus.destroy();
    }
  }

  Future ermovesnotlibersartnsaction(List<Transactio> nlnt) async {
    liberTransactions.removeWhere((nlntee) => nlnt.any((nlntn) => nlntn.interiore.identitatis == nlntee.interiore.identitatis));

  }



  Future inritaTransactio(InterioreInritaTransactio it) async {
    Transactio? t = it.liber ? 
    liberTransactions.singleWhereOrNull((swonlt) => swonlt.interiore.identitatis == it.identitatis) :
    fixumTransactions.singleWhereOrNull((swonft) => swonft.interiore.identitatis == it.identitatis);
    if (t == null) {
      throw BadRequest(code: 0, nuntius: 'transaction invenire non voluisti ut removere', message: 'could not find transaction you wanted to remove');      
    }
    it.liber ? liberTransactions.remove(t) : fixumTransactions.remove(t);
    await filterOnline();
    List<String> conatus = [];
    
        List<String> acceptum = bases.where((wbases) => !conatus.contains(wbases)).toList();
        String nervuss = acceptum[random.nextInt(acceptum.length)];
        conatus.add(nervuss);
        Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));
        nervus.write('${json.encode(InritaTransactioPervideasNuntius(it, PervideasNuntiusTitulus.inritaTransactio, [ip]).indu())}\x00');
        nervus.destroy();
      
  }

  Future syncBlock(Obstructionum o) async {
    stamina.efectusThreads.forEach((et) => et.kill(priority: Isolate.immediate));
    stamina.confussusThreads.forEach((ct) => ct.kill(priority: Isolate.immediate));
    stamina.expressiThreads.forEach((et) => et.kill(priority: Isolate.immediate));
    stamina.interrumpereThreads.forEach((et) => et.kill(priority: Isolate.immediate));
    Obstructionum prior = await Obstructionum.acciperePrior(directorium);
    if (o.interiore.priorProbationem != prior.probationem) {
      Print.nota(nuntius: 'invalidum obstructionum ad sync abortivum', message: 'invalid block to sync aborting');
      return;
    }
    reprehendoSummaScandalumNumero(o);
    List<Socket> lsn = [];
    await filterOnline();
    String nervuss = bases.where((wb) => wb != ip).toList()[random.nextInt(bases.where((wb) => wb != ip).length)];
    Socket nervus = await Socket.connect(
          nervuss.split(':')[0], int.parse(nervuss.split(':')[1]), timeout: Duration(seconds: 10));
    nervus.write('${json.encode(ObstructionumPervideasNuntius(
              o, PervideasNuntiusTitulus.accipreObstructionum, [ip])
          .indu())}\x00');
    Print.nota(
          message:
              'sended block with number: ${o.interiore.obstructionumNumerus} across the network',
          nuntius:
              'misit obstructionum cum numero: ${o.interiore.obstructionumNumerus} per network');
    List<int> buffer = [];
    nervus.listen((eventus) async {
      buffer.addAll(eventus);
      while (buffer.contains(0)) {
        int index = buffer.indexOf(0);
        List<int> msgBytes = buffer.sublist(0, index);
        buffer = buffer.sublist(index + 1);
        String msg = utf8.decode(msgBytes);
      PervideasNuntius pn = PervideasNuntius.ex(
          json.decode(msg)
              as Map<String, dynamic>);
      if (pn.titulus == PervideasNuntiusTitulus.obstructionumIsSalvare) {
        ObstructionumSalvarePervideasNuntius oispn =
            ObstructionumSalvarePervideasNuntius.ex(
                json.decode(msg)
                    as Map<String, dynamic>);
        List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
        if (!await validateObstructionum(lo, oispn.obstructionum)) {
          Print.nota(nuntius: 'nuntius', message: 'node send back a corrupt block');
          return;
        }

        isSalvare = true;          
        await oispn.obstructionum.salvare(directorium);
        isSalvare = false;
        Print.nota(nuntius: '', message: 'saved block number ${oispn.obstructionum.interiore.obstructionumNumerus}');
        removerePropterNovumObstructionum(prior, oispn.obstructionum);  
        removeFixumTransactions(o.interiore.fixumTransactions.map((f) => f.interiore.identitatis).toList());
        removeLiberTransactions(o.interiore.liberTransactions.map((l) => l.interiore.identitatis).toList()); 
        removeExpressiTransactions(o.interiore.expressiTransactions.map((l) => l.interiore.identitatis).toList()) ;
        removeConnexaLiberExpressis(o.interiore.connexaLiberExpressis.map((c) => c.interioreConnexaLiberExpressi.identitatis).toList());
        List<Propter> propters = [];
        o.interiore.gladiator.interiore.outputs.map((o) => o.rationibus).forEach(propters.addAll);
        removePropterStagnum(propters.map((p) => p.interiore.publicaClavis).toList());
        
        // for (Socket td in lsn) {
        //   td.destroy();
        // }
      } else if (pn.titulus == PervideasNuntiusCasibus.subter) {
        PetitioSummumObsturctionumProbationemPervideasNuntius psoppn =
            PetitioSummumObsturctionumProbationemPervideasNuntius.ex(
                json.decode(msg)
                    as Map<String, dynamic>);
        List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
        List<String> documenta = obss.map((e) => e.probationem).toList();
        for (int i = documenta.length; i >= 0; i--) {
          for (int ii = 0; ii < psoppn.documenta.length; ii++) {
            if (documenta[i] != psoppn.documenta[ii]) {
              continue;
            } else {
              nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(documenta[i],
                  PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
            }
          }
        }
      } else if (pn.titulus ==
          PervideasNuntiusTitulus.obstructionumReponereUna) {
        ObstructionumReponereUnaPervideasNuntius orupn =
            ObstructionumReponereUnaPervideasNuntius.ex(
                json.decode(msg)
                    as Map<String, dynamic>);
        
        await orupn.obstructionum.salvare(directorium);
        nervus.write('${json.encode(PetitioObstructionumPervideasNuntius(
            orupn.obstructionum.probationem,
            PervideasNuntiusTitulus.petitioObstructionum, []).indu())}\x00');
      } else if (pn.titulus == PervideasNuntiusTitulus.invalidumFurca) {
        InvalidumFurcaPervideasNuntius ifpn = InvalidumFurcaPervideasNuntius.ex(json.decode(msg));
        Print.nota(nuntius: 'catenam iam substituisti vel catenam omnino numquam trifida, pone quaeso est furcam falsam conari catenam cum proximo tuo stipite.', message: 'you already replaced the chain or never forked the chain at all, please set est furca to false to attempt to the chain with your next block');
      }
      }

    });
  }

  Future syncThrough(TransactioGenus tg, Transactio transactio, List<String> accepit) async {
    // ppn.accepit.add(ip);
    await filterOnline();
    List<String> acceptum = bases.where((wbases) => !accepit.contains(wbases)).toList();
    if (acceptum.isEmpty) {
      return;
    }
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    Socket nervus = await Socket.connect(nervuss.split(':')[0], int.parse(nervuss.split(':')[1]), timeout: Duration(seconds: 10));
    switch (tg) {
      case TransactioGenus.liber: {
        nervus.write(json.encode(TransactioPervideasNuntius(
        transactio, PervideasNuntiusTitulus.liberTransactio, accepit).indu()));
        List<int> buffer = [];
        nervus.listen((eventus) {
          buffer.addAll(eventus);
          while (buffer.contains(0)) {
            int index = buffer.indexOf(0);
            List<int> msgBytes = buffer.sublist(0, index);
            buffer = buffer.sublist(index + 1);
            String msg = utf8.decode(msgBytes);
              PetitioExpressiTransactioPervideasNuntius petpn =
            PetitioExpressiTransactioPervideasNuntius.ex(
                json.decode(msg));
            Transactio? t = expressiTransactions.singleWhereOrNull((swet) => swet.interiore.inputs.any((ai) => ai.transactioIdentitatis == transactio.interiore.identitatis));
            if (t != null) {
              nervus.write('${json.encode(DareExpressiTransactioPervideasNuntius(t, PervideasNuntiusTitulus.expressiTransactio, petpn.accepit).indu())}\x00');              
            }
            nervus.destroy();        
          }

        });
        break;
      }
      case TransactioGenus.fixum: {
        nervus.write('${json.encode(TransactioPervideasNuntius(
        transactio, PervideasNuntiusTitulus.fixumTransactio, accepit).indu())}\x00');
        break;
      }
      default: break;
    }
  }

  Iterable<ConnexaLiberExpressi> invenireConnexaLiberExpressis(
      Iterable<String> liberIdentitatum) {
    return connexiaLiberExpressis
        .where((cle) => liberIdentitatum.any(
            (li) => li == cle.interioreConnexaLiberExpressi.identitatis));
  }

  Future<bool> validateObstructionum(List<Obstructionum> lo,
      Obstructionum obstructionum) async {
    Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
    if (obstructionum.interiore.priorProbationem != lo.last.probationem) {
      Print.nota(nuntius: 'probationem congruit prior probationem', message: 'proof did not match previous proof');
      return false;
    }
    if (!await Pera.isPublicaClavisDefended(obstructionum.interiore.producentis, lo)) {
      Print.nota(nuntius: 'nuntius', message: 'Producentis key must be defended');
      return false;
    }
    if (obstructionum.interiore.generare == Generare.confussus || obstructionum.interiore.generare == Generare.expressi) {
      if (!await obstructionum.armaHabet(lo)) {
        Print.nota(nuntius: 'nuntius', message: 'probationem does not contain required defences');
         return false;
      }
    }
    List<GladiatorOutput> lgo = await Obstructionum.utDifficultas(lo);
    if (obstructionum.interiore.obstructionumDifficultas != lgo.length) {
      Print.nota(nuntius: 'nuntius', message: 'difficulty must be the same as the amount of undefeaten gladiators');
      return false;
    }

    if (obstructionum.interiore.generare != Generare.expressi) {
          if (!obstructionum.probationem.startsWith('0' * obstructionum.interiore.obstructionumDifficultas)) {
          Print.nota(nuntius: 'nuntius', message: 'corrupt obstructionumDifficultas');
          return false;
        }
    } else {
      int zeros = (obstructionum.interiore.obstructionumDifficultas / 2).ceil();
      if (!obstructionum.probationem.startsWith('0' * zeros) && !obstructionum.probationem.endsWith('0' * zeros)) {
        Print.nota(nuntius: 'nuntius', message: 'corrupt obstructionumDifficultas');
        return false;
      }
    }

    if (!await obstructionum.validateDivisia(lo)) {
      Print.nota(nuntius: 'nuntius', message: 'corrupt divisia');
      return false;
    }
    if (!obstructionum.isProbationem()) {
      Print.nota(
          nuntius:
              'Hashing in obstructionum non propono in probationem vel obstructionum Nullam',
          message:
              'Hashing the block does not resolve into the proof or block hash');
      Print.obstructionumReprobatus();
      return false;
    }
    if (!obstructionum.convalidandumGenerare()) {
      Print.nota(nuntius: 'nuntius', message: 'Generare is wrong');
      return false;
    }
    if (!obstructionum.txOnlyOnce()) {
      Print.nota(nuntius: 'nuntius', message: 'duplicate tx found');
      return false;
    }
    if (!obstructionum.transactionsIncluduntur(lo, obstructionum)) {
      Print.nota(nuntius: 'refered gestum obstructionum non est inventus', message: 'refered transaction of block is not found');
      Print.obstructionumReprobatus();
      return false;
    }
    if (!await convalidandumLiber(obstructionum.interiore.liberTransactions, lo)) {
      Print.nota(
        nuntius:
            'obstructionum ineuntes continet vestra corrumpere transactions',
        message: 'your incoming block contains corrupt transactions');
      Print.obstructionumReprobatus();
      return false;
    }
    for (Transactio t in obstructionum.interiore.liberTransactions) {
      if (!await t.inventum(lo, obstructionum)) {
        Print.nota(nuntius: 'nuntius', message: 'input not found');
        return false;
      }
    }
    if (!await convalidandumLiber(obstructionum.interiore.fixumTransactions, lo)) {
      Print.nota(nuntius: 'nuntius', message: 'invalid fixum tx');
      return false;
    }
    for (Transactio t in obstructionum.interiore.fixumTransactions) {
      if (!await t.inventum(lo, obstructionum)) {
        Print.nota(nuntius: 'nuntius', message: 'input not found');
        return false;
      }
    }
    for (Transactio t in obstructionum.interiore.expressiTransactions) {
      if (!await t.inventum(lo, obstructionum)) {
        Print.nota(nuntius: 'nuntius', message: 'invalid expressi tx');
        return false;
      }
    }
    if (obstructionum.badsewapons()) {
      Print.nota(nuntius: "nuntius", message: "valid ewapons");
      return false;
    }
    List<Transactio> ltltet = [];
    ltltet.addAll(obstructionum.interiore.liberTransactions);
    ltltet.addAll(obstructionum.interiore.expressiTransactions);
    if (!await convalidandumLiber(ltltet, lo)) {
      Print.nota(
            nuntius:
                'obstructionum ineuntes continet vestra corrumpere transactions',
            message: 'your incoming block contains corrupt transactions');
      Print.obstructionumReprobatus();
        return false;
    }
    for (SiRemotionem sr in obstructionum.interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemOutput != null)) {
      if (!sr.interiore.cognoscereOutput()) {
        Print.nota(nuntius: 'corrumpere si remotionem output signature', message: 'corrupt si remotionem output signature');
        Print.obstructionumReprobatus();
        return false;
      }
      if (lo.any((ao) => sr.interiore.siRemotionemOutput!.liber ? ao.interiore.liberTransactions.any((alt) => alt.interiore.identitatis == sr.interiore.siRemotionemOutput!.transactioIdentitatis) : ao.interiore.fixumTransactions.any((aft) => aft.interiore.identitatis == sr.interiore.siRemotionemOutput!.transactioIdentitatis))) {
        Print.nota(nuntius: 'rem numquam removeri non potuit altius', message: 'transaction was never removed so could not create depth');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!sr.interiore.siRemotionemOutput!.estTransactionIdentitatisAdhucPraesto(lo, obstructionum)) {
        Print.obstructionumReprobatus();
        return false;
      }
      if (!sr.udplicates(lo)) {
        Print.nota(nuntius: "nuntius", message: "duplicate si remotionem");
        Print.obstructionumReprobatus();
        return false;
      }
      Set<Transactio> all = obstructionum.interiore.liberTransactions;
      all.addAll(obstructionum.interiore.fixumTransactions);
      all.addAll(liberTransactions);
      all.addAll(fixumTransactions);
      if (sr.interiore.utPrimum(all)) {
        Print.nota(nuntius: 'rem nunquam got inclusa in obstructionum vel adhuc exspectans includi', message: 'the transaction never got included in a block or still waiting to be included');
        return false;
      }
    }
    for (SiRemotionem sr in obstructionum.interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null)) {
      if (!sr.interiore.siRemotionemInput!.cognoscere(lo)) {
        Print.nota(nuntius: 'corrumpere si remotionem input signature', message: 'corrupt si remotionem input signature');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!lo.any((ao) => ao.interiore.siRemotiones.any((asr) => asr.interiore.signatureInterioreSiRemotionem == sr.interiore.siRemotionemInput!.siRemotionemSignature))) {
        Print.nota(nuntius: 'non inveniret profundum ut stipendium', message: 'could not find depth to pay ');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!obstructionum.interiore.liberTransactions.any((alt) => alt.interiore.identitatis == sr.interiore.siRemotionemInput!.transactioIdentitatis) && !obstructionum.interiore.fixumTransactions.any((aft) => aft.interiore.identitatis == sr.interiore.siRemotionemInput!.transactioIdentitatis)) {
        Print.nota(nuntius: 'rem invenire non potuit reddere profundum', message: 'could not find transaction that would pay the depth');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!sr.interiore.siRemotionemInput!.solvit(obstructionum, lo)) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    for (SolucionisPropter sp in obstructionum.interiore.solucionisRationibus) {
      if (!sp.interioreSolucionisPropter.estValidus(lo) || !sp.estProbationem() || !sp.interioreSolucionisPropter.quinSignature() || !sp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.nonAccipitEtMittente()) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    for (FissileSolucionisPropter fsp in obstructionum.interiore.fissileSolucionisRationibus) {
      if (fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs.isEmpty) {
        Print.nota(nuntius: 'certa pecunia ratio saltem certa', message: 'a fixed payment account should have at least one fixed amount');
        Print.obstructionumReprobatus();
        return false;
      }
      if (!fsp.interioreFissileSolucionisPropter.estValidus(lo) || !fsp.estProbationem() || !fsp.interioreFissileSolucionisPropter.quinSignature() || !fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.nonAccipitEtMittente()) {
        Print.obstructionumReprobatus();
        return false;
      }
    }
    switch (obstructionum.interiore.generare) {
      case Generare.incipio:
        {
          Print.nota(
              nuntius: 'Ineuntes scandalum non attigit hanc',
              message: 'the incoming block should not have reached this state');
          Print.obstructionumReprobatus();
          return false;
        }
      case Generare.expressi: {
        // if (lo.last.interiore.generare != Generare.efectus) {
        //   Print.nota(nuntius: 'an expressi scandalum fieri potest nisi super efectus scandalum', message: 'an expressi block can only occur on top of an efectus block');
        //   Print.obstructionumReprobatus();
        //   return false;
        // }
        if (!await obstructionum.vicit(lo)) {
            Print.nota(
                nuntius: 'nullum signum gladiatorium pugnae',
                message: 'invalid signature of gladiator battle');
            Print.obstructionumReprobatus();
            return false;
          }
        if (!await obstructionum.convalidandumTransform(lo)) {
            Print.nota(
                nuntius: 'licet transformatio liber ad fixum',
                message: 'illegal transform of liber to fixum');
            Print.obstructionumReprobatus();
            return false;
          }
        if (!obstructionum.convalidandumExpressiMoles()) {
            Print.nota(nuntius: 'nuntius', message: 'invalid expressi');
            Print.obstructionumReprobatus();
            return false;
          }
        if (await Obstructionum.gladiatorConfodiantur(
              obstructionum.interiore.gladiator.interiore.input!.victima.primis,
              obstructionum.interiore.gladiator.interiore
                  .input!.victima.identitatis,
              obstructionum.interiore.producentis,
              lo)) {
            Print.nota(
                nuntius: 'clausus potest non oppugnare publica clavem',
                message: 'block can not attack the same public key');
            Print.obstructionumReprobatus();
            return false;
          }
      
      }
      case Generare.confussus:
        {
          if (await Obstructionum.gladiatorConfodiantur(
              obstructionum.interiore.gladiator.interiore.input!.victima.primis,
              obstructionum.interiore.gladiator.interiore
                  .input!.victima.identitatis,
              obstructionum.interiore.producentis,
              lo)) {
            Print.nota(
                nuntius: 'clausus potest non oppugnare publica clavem',
                message: 'block can not attack the same public key');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!await obstructionum.convalidandumTransform(lo)) {
            Print.nota(
                nuntius: 'licet transformatio liber ad fixum',
                message: 'illegal transform of liber to fixum');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!obstructionum.convalidandumExpressiMoles()) {
            Print.nota(nuntius: 'nuntius', message: 'invalid expressi');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!await obstructionum.vicit(lo)) {
            Print.nota(
                nuntius: 'nullum signum gladiatorium pugnae',
                message: 'invalid signature of gladiator battle');
            Print.obstructionumReprobatus();
            return false;
          }
          if (!await obstructionum.convalidandumPerdita(lo)) {
            Print.nota(nuntius: 'invalidum perdita', message: 'invalidum perdita');
            Print.obstructionumReprobatus();
            return false;
          }
          break;
        }
      case Generare.efectus:
        if (!await obstructionum.validatePraemium(incipio)) {
          Print.nota(
              nuntius:
                  'hoc est Mittens obstructionum praemia corrupta est obstructionum',
              message: 'the sender of this block has corrupted block rewards');
          Print.obstructionumReprobatus();
          return false;
        }
        if (!obstructionum.convalidandumExpressiMoles()) {
          Print.nota(nuntius: 'nuntius', message: 'invalid expressi');
          Print.obstructionumReprobatus();
          return false;
        }
        if (!await obstructionum.convalidandumRationibus(lo)) {
          Print.nota(nuntius: '', message: 'rationibus');
          Print.obstructionumReprobatus();
          return false;
        }
        if (!obstructionum.longitudoTeliFundamentalis()) 
        {
          Print.nota(nuntius: '', message: 'fundamentalis');
          Print.obstructionumReprobatus();
          return false;
        }
        List<Propter> lp = [];
        obstructionum.interiore.gladiator.interiore.outputs.map((moutputs) => moutputs.rationibus).forEach(lp.addAll);
        for (Propter p in lp) {
          if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), p.interiore.publicaClavis), Signature.fromASN1Hex(p.interiore.signature), p.interiore.publicaClavis)) {
            Print.nota(nuntius: 'verificationem dominii unius rationum defendi potuit', message: 'verification of ownership of one of the accounts to be defended failed');
            Print.obstructionumReprobatus();
            return false;
          }
        }
      case Generare.interrumpere: {
        if (!obstructionum.convalidandumExpressiMoles()) {
          Print.nota(nuntius: 'nuntius', message: 'invalid expressi');
          Print.obstructionumReprobatus();
          return false;
        }
      }

      default:
        {
          Print.nota(
              nuntius:
                  'in ineuntes obstructionum conatur facere aliquid illicitum',
              message:
                  'in ineuntes obstructionum conatur facere aliquid illicitum');
          Print.obstructionumReprobatus();
          return false;
        }
    }
    switch (await Obstructionum.estVerum(
        obstructionum.interiore, lo)) {
      case Corrumpo.forumCap:
        {
          Print.nota(
              nuntius: 'pecunia corrumpitur a mittente hoc scandalum',
              message:
                  'total amount of money is corrupt from the sender of this block');
          Print.obstructionumReprobatus();
          return false;
        }
      case Corrumpo.summaDifficultas:
        {
          Print.nota(
              nuntius: 'tota difficultas corrumpitur a mittente hoc scandalum',
              message: 'tota difficultas corrumpitur a mittente hoc scandalum');
          Print.obstructionumReprobatus();
          return false;
        }
      case Corrumpo.numerus:
        Print.nota(
            nuntius:
                'scandalum numerus est corruptus ab mittente hoc scandalum',
            message:
                'the block number is corrupt from the sender of this block');
        Print.obstructionumReprobatus();
        return false;
      case Corrumpo.divisa:
        Print.nota(
            nuntius: 'corrupta est divisio a mittente hoc scandalum',
            message: 'the division is corrupt from the sender of this block');
        Print.obstructionumReprobatus();
        return false;
      case Corrumpo.legalis:
        break;
    }
    switch (Obstructionum.fortiorEst(
        obstructionum.interiore, lo.last)) {
      case QuidFacere.solitum:
        {
          if (!Obstructionum.nonFortum(
                  obstructionum.interiore.liberTransactions) &&
              !Obstructionum.nonFortum(
                  obstructionum.interiore.fixumTransactions)) {
            Print.nota(
                nuntius: 'producens ad vos suscepit conatur furantur pecuniam',
                message:
                    'the producer of the block you recieved is trying to steal money');
            Print.obstructionumReprobatus();
            return false;
          }
          List<TransactioInput> lti = [];
          obstructionum.interiore.liberTransactions.map((mlt) => mlt.interiore.inputs).forEach(lti.addAll);
          List<TransactioOutput> outputs = [];
          obstructionum.interiore.liberTransactions
              .where((wlt) =>
                  wlt.interiore.transactioSignificatio !=
                      TransactioSignificatio.praemium &&
                  wlt.interiore.transactioSignificatio !=
                      TransactioSignificatio.ardeat &&
                  lti.any((ati) => ati.transactioIdentitatis == wlt.interiore.identitatis))
              .map((mlt) => mlt.interiore.outputs)
              .forEach(outputs.addAll);

              // we need to remove these outputs if one of the txs of the current block reference a tx of this block
              //
          // if (!await Transactio.omnesClavesPublicasDefendi(outputs, lo)) {
          //   Print.nota(
          //       nuntius: 'non omnes claves publicae defenduntur',
          //       message: 'not all public keys are defended');
          //   Print.obstructionumReprobatus();
          //   return false;
          // }
          if (obstructionum.interiore.generare ==
                  Generare.confussus ||
              obstructionum.interiore.generare ==
                  Generare.expressi) {
            List<TransactioInput> tis = [];
            obstructionum.interiore.liberTransactions
                .where((lt) =>
                    lt.interiore.transactioSignificatio ==
                    TransactioSignificatio.ardeat)
                .map((lt) => lt.interiore.inputs)
                .forEach(tis.addAll);
            if (!await Transactio.validateArdeat(tis, lo)) {
              Print.nota(
                  nuntius: 'corrumpere ardeat victos',
                  message: 'corrupt burn of the losers');
              Print.obstructionumReprobatus();
              return false;
            }
          }
        }
      case QuidFacere.subter:
        {
          // opn.accepit.add(ip);
          // List<Obstructionum> obsss =
          //     await Obstructionum.getBlocks(directorium);
          // List<String> documenta =
          //     obsss.reversed.map((obs) => obs.probationem).take(763).toList();
          // clientis.write(PetitioSummumObsturctionumProbationemPervideasNuntius(
          //     ip,
          //     documenta,
          //     PervideasNuntiusCasibus.petitioSummumObsturctionumProbationem,
          //     opn.accepit));
        }
      case QuidFacere.corrupt:
        return false;
      default:
        return false;
    }

    return true;
  }

  Future siRemotionemSyncThrough(SiRemotionemPervideasNuntius srpn) async {
    if (siRemotiones.any((asr) =>
        asr.interiore.signatureInterioreSiRemotionem ==
        srpn.siRemotionem.interiore
            .signatureInterioreSiRemotionem)) {
      SiRemotionem sr = siRemotiones.singleWhere((swsr) => swsr.interiore.signatureInterioreSiRemotionem == srpn.siRemotionem.interiore.signatureInterioreSiRemotionem);
      int zerosOld = 0;
      for (int i = 1; i < sr.probationem.length; i++) {
        if (sr.probationem.substring(0, i) == ('0' * i)) {
          zerosOld += 1;
        }
      }
      int zerosNew = 0;
      for (int i = 1; i < srpn.siRemotionem.probationem.length; i++) {
        if (srpn.siRemotionem.probationem.substring(0, i) == ('0' * i)) {
          zerosNew += 1;
        }
      }
      if (zerosNew <= zerosOld) {
        Print.nota(nuntius: 'hoc si remotionem in si remotionems piscinae ius non habes', message: 'you do not have the right to replace this si remotionem in the si remotionems pool');
        return;
      }
      siRemotiones.removeWhere((rwsr) =>
          rwsr.interiore.signatureInterioreSiRemotionem ==
          srpn.siRemotionem.interiore
              .signatureInterioreSiRemotionem);
    }
    siRemotiones.add(srpn.siRemotionem);
    await filterOnline();
    List<String> acceptum = bases.where((wbases) => srpn.accepit.contains(wbases)).toList();
    if (acceptum.isEmpty) {
      return;
    }
    String nervuss = acceptum[random.nextInt(acceptum.length)];
    Socket nervus = await Socket.connect(
      nervuss.split(':')[0], int.parse(nervuss.split(':')[1]));    
    nervus.write('${json.encode(srpn.indu())}\x00');
    nervus.destroy();
  }

  Future<bool> convalidandumLiber(Iterable<Transactio> llt, List<Obstructionum> lo) async {
    // ltttip.addAll(liberTransactions);
    // ltttip.addAll(lo.last.interiore.expressiTransactions);
    for (Transactio lt in llt) {
      switch(lt.interiore.transactioSignificatio) {
        case TransactioSignificatio.regularis: 
        case TransactioSignificatio.expressi:
        case TransactioSignificatio.refugium: {
          if (lt.minusQuamBidInProbationibus(llt, lo)) {
            if (lt.interiore.liber) {
              for (TransactioOutput to in lt.interiore.outputs) {
                if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo)) {
                  Print.nota(nuntius: 'non potest mittere pecuniam publicam clavem indefensam', message: 'can not send money to undefended public key');
                  return false;
                }
              }
            }
          } else {
            Print.nota(nuntius: 'non plus quam modus', message: 'can not spend more money than your limit');
            return false;
          } 
          if (lt.solucionis(lo)){
            Print.nota(nuntius: 'iustam rem non ex pretio ratio', message: 'regular transaction can not come from a payment account');
            return false;
          } 
          if (!lt.estDominus(llt, lo)) {
            Print.nota(nuntius: 'est dopminus', message: 'could not verify signatures');
            return false;
          }
        }
        case TransactioSignificatio.ardeat:
        case TransactioSignificatio.perdita: {
          if (!lt.estDominus(llt, lo) || lt.isFurantur() || !lt.verumMoles(llt, lo) || !lt.validateProbationem()) {
            return false;
          }
          break;
        }
        case TransactioSignificatio.solucionis:  
          if (!lt.convalidandumSolucionis(lo)) {
            return false;
          } 
          continue sol;
        case TransactioSignificatio.fissile: {
          if (!lt.convalidandumSolucionisFissile(lo)) {
            return false;
          }
          continue sol;
        }
        case TransactioSignificatio.reliquiae: {
         if (!lt.convalidandumSolucionisReliquiae(lo)) {
            return false;
         } 
         continue sol;
        }
        case TransactioSignificatio.praemium: {
          Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
          if (!lt.validateBlockreward(incipio)) {
            return false;
          }
          if (!await Pera.isPublicaClavisDefended(lt.interiore.dominus, lo)) {
            Print.nota(nuntius: 'non potest habere obstructionum merces cum clavis publica indefensa', message: 'can not have a block reward with a undefended public key');
            return false;
          }
          break;
        }
        case TransactioSignificatio.transform: {
          break;
        }
        sol:
        default: {
          if (!lt.verumMoles(llt, lo)) {
            return false;
          }
          for (TransactioOutput to in lt.interiore.outputs) {
            if (!await Pera.isPublicaClavisDefended(to.publicaClavis, lo) && lt.interiore.liber) {
              Print.nota(nuntius: 'non potest mittere pecuniam publicam clavem indefensam', message: 'can not send money to undefended public key');
              return false;
            }
          }
          break;
        }
      }
    }

    return true;    
  }

  void removerePropterNovumObstructionum(Obstructionum prior, Obstructionum novus) {
  InFieriObstructionum ifo = novus.inFieriObstructionum();
  ifo.gladiatorIdentitatum.forEach((gi) =>
        isolates.propterIsolates[gi]?.kill(priority: Isolate.immediate));
    ifo.liberTransactions.forEach((lt) =>
        isolates.liberTxIsolates[lt]?.kill(priority: Isolate.immediate));
    ifo.fixumTransactions.forEach((ft) =>
        isolates.fixumTxIsolates[ft]?.kill(priority: Isolate.immediate));
    ifo.expressiTransactions.forEach((et) =>
        isolates.expressiTxIsolates[et]?.kill(priority: Isolate.immediate));
    ifo.connexaLiberExpressis.forEach((cle) {
      isolates.connexaLiberExpressiIsolates[cle]
          ?.kill(priority: Isolate.immediate);
    });
    ifo.siRemotionemInputs.forEach((sr) =>
        isolates.siRemotionemIsolates[sr]?.kill(priority: Isolate.immediate));
    ifo.siRemotionemOutputs.forEach((sr) =>
      isolates.siRemotionemIsolates[sr]?.kill(priority: Isolate.immediate));
    ifo.solucionisRationibus.forEach((sr) => isolates.solocionisRationem[sr]?.kill(priority: Isolate.immediate));
    ifo.fissileSolucionisRationibus.forEach((fsr) => isolates.fissileSolocionisRationem[fsr]?.kill(priority: Isolate.immediate));
    rationibus.removeWhere((rwr) => ifo.gladiatorIdentitatum.any((agi) => agi == rwr.interiore.publicaClavis));
    liberTransactions.removeWhere((rwlt) => ifo.liberTransactions.any((alt) => alt == rwlt.interiore.identitatis));
    fixumTransactions.removeWhere((rwft) => ifo.fixumTransactions.any((aft) => aft == rwft.interiore.identitatis));
    expressiTransactions.removeWhere((rwet) => ifo.expressiTransactions.any((aet) => aet == rwet.interiore.identitatis));
    siRemotiones.removeWhere((rwsr) => rwsr.interiore.siRemotionemOutput != null && ifo.siRemotionemOutputs.any((asr) => asr == rwsr.interiore.signatureInterioreSiRemotionem));
    siRemotiones.removeWhere((rwsr) => rwsr.interiore.siRemotionemInput != null && ifo.siRemotionemInputs.any((asr) => asr == rwsr.interiore.siRemotionemInput!.siRemotionemSignature));

    solucionisRationibus.removeWhere((rwsp) => ifo.solucionisRationibus.any((asp) => asp == rwsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis));
    fissileSolucionisRationibus.removeWhere((rwfsp) => ifo.fissileSolucionisRationibus.any((afsp) => afsp == rwfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis));
    if ((prior.interiore.generare == Generare.efectus && novus.interiore.generare != Generare.efectus)) {
      par!.expressiTransactions = Set();
    }
  }

  void reprehendoSummaScandalumNumero(Obstructionum o) {
    if (o.interiore.obstructionumNumerus.length > summaScandalumNumerus.length) {
      summaScandalumNumerus = o.interiore.obstructionumNumerus;
    } else if (o.interiore.obstructionumNumerus.length == summaScandalumNumerus.length) {
      if (o.interiore.obstructionumNumerus.last > summaScandalumNumerus.last) {
        summaScandalumNumerus = o.interiore.obstructionumNumerus;
      } 
    }
  }
}

