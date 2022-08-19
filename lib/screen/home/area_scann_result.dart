import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AreaScannResultado extends StatelessWidget {
  String resultado;
  String observacao;
  bool valido;

  AreaScannResultado(
      {Key? key,
      required this.resultado,
      required this.observacao,
      required this.valido})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Text(
            resultado,
            style: GoogleFonts.openSans(fontSize: 15),
          ),
          const SizedBox(height: 20),
          valido
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  color: const Color.fromARGB(200, 25, 182, 25),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  color: const Color.fromARGB(199, 209, 29, 29),
                ),
          const SizedBox(height: 20),
          Text(
            observacao,
            style:
                GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
