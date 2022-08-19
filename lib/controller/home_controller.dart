import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeController {
  bool valido = false;
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

    if (code != '-1') {
      ticket = true;
    }
  }

  String _validacoes(String qrcode) {
    String retorno = '';

    //TODO:: Verifica se é um link válido
    bool contains = qrcode.contains('#');

    if (!contains) {
      retorno =
          'ERRO! O QR code \"$qrcode\" não pertence a uma loja ou máquina!';
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
}
