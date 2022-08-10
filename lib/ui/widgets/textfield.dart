import 'package:bramstore/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? textfield;
  final double? height;
  final String? texthint;
  TextFieldWidget(
      {Key? key, this.textfield, this.height = 40, this.texthint = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: height,
        child: TextField(
          controller: textfield,
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: const Color(0xFF151624),
          ),
          maxLines: 1,
          keyboardType: TextInputType.text,
          cursorColor: const Color(0xFF151624),
          decoration: InputDecoration(
            hintText: texthint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            filled: true,
            fillColor: textfield!.text.isEmpty
                ? const Color.fromRGBO(248, 247, 251, 1)
                : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(
                  color: textfield!.text.isEmpty
                      ? Colors.transparent
                      : ksecondcolor,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(
                  color: ksecondcolor,
                )),
            prefixIcon: Icon(
              Icons.search,
              color: textfield!.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : ksecondcolor,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
