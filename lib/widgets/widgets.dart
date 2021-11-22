import 'package:flutter/material.dart';

Container longButtons(String title, Function fun,
    {Color color: const Color(0xfff063057), Color textColor: Colors.white}) {
  return Container(
    padding: EdgeInsets.only(left: 250),
    child: Align(
      alignment: Alignment.bottomRight,
      child: MaterialButton(
        onPressed: fun,
        textColor: textColor,
        color: color,
        child: SizedBox(
          width: double.infinity,
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        height: 50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    ),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration( IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
