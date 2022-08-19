import 'package:flutter/material.dart';

class AreaScannImg extends StatelessWidget {
  const AreaScannImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(50),
      child: Image.asset("images/qr-code-gc.png"),
    );
  }
}
