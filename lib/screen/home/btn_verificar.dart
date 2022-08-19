import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BtnVerificar extends StatelessWidget {
  void Function() verificar;
  void Function() limpar;

  BtnVerificar({Key? key, required this.verificar, required this.limpar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: verificar,
            style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 25, 42, 194)),
            child: Text(
              'VERIFICAR',
              style: GoogleFonts.ubuntu(fontSize: 16),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: limpar,
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 216, 125, 21)),
            child: Text(
              'LIMPAR',
              style: GoogleFonts.ubuntu(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
