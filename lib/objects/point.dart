import 'package:flutter/material.dart';

class KataPoint extends StatelessWidget {
  const KataPoint({Key? key, this.value, this.pos, this.i, this.onclick})
      : super(key: key);
  final String? value;
  final int? pos;
  final int? i;
  final Function? onclick;

  @override
  Widget build(BuildContext context) {
    var col = Colors.white;
    if (pos == i) col = Colors.yellow;
    if (pos == 99) col = Colors.green;
    var borderCol = Colors.black26;
    if (pos == i) borderCol = Colors.yellow;
    if (pos == 99) borderCol = Colors.black26;
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(border: Border.all(color: borderCol, width: 3)),
      child: InkWell(
        onTap: () => {onclick!()},
        child: Text(value!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: col,
              fontSize: 35.0,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
//                            color: Colors.white,
            )),
      ),
    ));
  }
}
