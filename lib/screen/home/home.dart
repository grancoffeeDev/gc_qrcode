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

    obs = _validacoes(code);

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
        ticket
            ? AreaScannResultado(
                resultado: code, observacao: obs, valido: valido)
            : const AreaScannImg(),
        BtnVerificar(verificar: readQrCode, limpar: cleanCode),
        ElevatedButton(
            onPressed: () async {
              String jsession = await loginSkw();
              print(jsession);
              logoutSkw(jsession.toString());
            },
            child: Text('OI'))
      ]),
      backgroundColor: Colors.white,
    );
  }
}

String _validacoes(String qrcode) {
  String retorno = '';

  //TODO:: Verifica se é um link válido
  bool contains = qrcode.contains('#');

  if (!contains) {
    retorno = 'ERRO! O QR code "$qrcode" não pertence a uma loja ou máquina!';
  } else {
    //TODO:: Verifica o patrimônio
    int contagem = qrcode.indexOf('#');
    int totalcaracteres = qrcode.length;
    String pt = qrcode.substring(contagem + 1, totalcaracteres);

    retorno = pt;
    valido = true;
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
  await Dio().post(url, data: body);
}
