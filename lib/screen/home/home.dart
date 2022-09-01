import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'area_scann.dart';
import 'area_scann_result.dart';
import 'area_txt.dart';
import 'btn_verificar.dart';

bool valido = false;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ticket = false;
  String code = '';
  String obs = '';

  readQrCode() async {
    valido = false;
    code = await FlutterBarcodeScanner.scanBarcode(
      '#FFFFFF',
      'Cancelar',
      false,
      ScanMode.QR,
    );

    obs = await _validacoes(code);

    setState(() {
      if (code != '-1') {
        ticket = true;
      }
    });
  }

  cleanCode() {
    setState(() {
      ticket = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Center(child: Text('Validador de QR Code'))),
      body: Column(children: [
        const AreaTexto(),
        RepaintBoundary(
          child: ticket
              ? AreaScannResultado(
                  resultado: code, observacao: obs, valido: valido)
              : const AreaScannImg(),
        ),
        RepaintBoundary(
            child: BtnVerificar(verificar: readQrCode, limpar: cleanCode)),
      ]),
      backgroundColor: Colors.white,
    );
  }
}

Future<String> _validacoes(String qrcode) async {
  String retorno = '';

  //TODO:: Verifica se é um link válido
  bool contains = qrcode.contains('#');

  if (!contains) {
    retorno = 'ERRO! O link "$qrcode" não pertence a uma loja ou máquina!';
  } else {
    //TODO:: Verifica o patrimônio
    int contagem = qrcode.indexOf('#');
    int totalcaracteres = qrcode.length;
    String pt = qrcode.substring(contagem + 1, totalcaracteres);

    String jsession = await loginSkw();
    int existe = await validaPatrimonio(jsession, pt);
    if (existe > 0) {
      retorno = pt;
      valido = true;
    } else {
      retorno = 'ERRO! Patrimônio $pt Inválido!';
    }
    //print(retorno2);
    await logoutSkw(jsession);
  }

  return retorno;
}

Future<String> loginSkw() async {
  String url =
      'http://sankhya.grancoffee.com.br:8180/mge/service.sbr?serviceName=MobileLoginSP.login&outputType=json';
  String body =
      "{\"serviceName\":\"MobileLoginSP.login\",\"requestBody\":{\"NOMUSU\":{\"\$\":\"GABRIEL\"},\"INTERNO\":{\"\$\":\"gabriel123456\"},\"KEEPCONNECTED\":{\"\$\":\"S\"}}}";
  var response = await Dio().post(url, data: body);
  return response.data['responseBody']['jsessionid']['\$'].toString();
}

logoutSkw(String jsession) async {
  String url =
      'http://sankhya.grancoffee.com.br:8180/mge/service.sbr?serviceName=MobileLoginSP.logout&outputType=json&mgeSession=$jsession';
  String body =
      "\"serviceName\":\"MobileLoginSP.logout\",\"status\":\"1\",\"pendingPrinting\":\"false\",}";
  await Dio().post(url,
      data: body,
      options: Options(headers: {'Cookie': 'JSESSIONID=$jsession'}));
}

Future<int> validaPatrimonio(String jsession, String patrimonio) async {
  String url =
      'http://sankhya.grancoffee.com.br:8180/mge/service.sbr?serviceName=DbExplorerSP.executeQuery&mgeSession=$jsession';
  String body =
      '{"serviceName":"DbExplorerSP.executeQuery","requestBody":{"sql":"SELECT COUNT(*) AS QTD FROM TCIBEM WHERE CODBEM=\'$patrimonio\'"}}';
  Response respose = await Dio().post(url,
      data: body,
      options: Options(
          headers: {'Cookie': 'JSESSIONID=$jsession'},
          responseType: ResponseType.json));
  Map parsed = json.decode(respose.data);
  return parsed['responseBody']['rows'][0][0];
}
