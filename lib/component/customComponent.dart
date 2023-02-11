import 'package:flutter/material.dart';

ListTile listTiles(String text, Icon icon, void Function()? fun) {
  return ListTile(leading: icon, title: Text("$text"), onTap: fun);
}

// textform with icon
TextFormField textform(
    String hint,
    bool state,
    IconData icon,
    TextEditingController textcontroller,
    String? Function(String?) textvalidate) {
  return TextFormField(
    cursorColor: Color(0xff262A4C),
    textAlign: TextAlign.end,
    obscureText: state,
    controller: textcontroller,
    validator: textvalidate,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xff9199C0)),
        suffixIcon: Icon(icon, color: Color(0xff505B96)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xff505B96),
        ))),
  );
}

// without icons
TextFormField textformfilde(String hint, TextEditingController controller,
    String? Function(String?) textvalidate) {
  return TextFormField(
      controller: controller,
      validator: textvalidate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xff9199C0)),
          //suffixIcon: Icon(icon, color: Color(0xff505B96)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff505B96),
          ))));
}

//to write more than one line
TextFormField textFormField2(String hint, TextEditingController controller) {
  return TextFormField(
      textAlign: TextAlign.right,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xff9199C0)),
          //suffixIcon: Icon(icon, color: Color(0xff505B96)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff505B96),
          ))));
}

//custom button
ElevatedButton button(hint, void Function()? fun) {
  return ElevatedButton(
    onPressed: fun,
    style: ElevatedButton.styleFrom(
      shadowColor: const Color(0xff262A4C),
      elevation: 15,
      primary: const Color(0xff262A4C),
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Ink(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff262A4C),
            Color(0xff505B96),
            //Color(0xff9199C0)
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50, maxWidth: 300),
        alignment: Alignment.center,
        child: Text(
          "$hint",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

//
Text text(hint, fontsize, Color color) {
  return Text(
    "$hint",
    style: TextStyle(
      fontSize: fontsize,
      color: color,
    ),
    textAlign: TextAlign.right,
  );
}

/////////////////////////////////
///
class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 50, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

//====================================================================================
// class dropdown extends StatefulWidget {
//   final String hint;
//   final List<dynamic> category;
//   var selectedvalue;
//   dropdown(
//       {Key? key,
//       required this.category,
//       required this.selectedvalue,
//       required this.hint})
//       : super(key: key);

//   @override
//   State<dropdown> createState() => _dropdownState();
// }

// class _dropdownState extends State<dropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//       alignment: Alignment.bottomLeft,
//       hint: Text(widget.hint),
//       dropdownColor: Colors.white,
//       //  style: const TextStyle(),
//       isExpanded: true,
//       value: widget.selectedvalue,
//       items: widget.category.map((cat) {
//         return DropdownMenuItem(
//           child: Text(
//             cat['name'],
//           ),
//           value: cat['id'],
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           widget.selectedvalue = value;
//         });

//         print(widget.selectedvalue);
//       },
//     );
//   }
// }
