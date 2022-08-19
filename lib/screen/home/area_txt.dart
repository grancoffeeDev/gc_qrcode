import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AreaTexto extends StatelessWidget {
  const AreaTexto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 50),
      child: Center(
        child: Text(
          'Validador de QR Code',
          style:
              GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
