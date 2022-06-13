import 'package:flutter/material.dart';

class KataButton2 extends StatelessWidget {
  const KataButton2({Key? key, this.value, this.onclick}) : super(key: key);
  final String? value;
  final Function? onclick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => {onclick!()},
          child: Text(value!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 70.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
//                            color: Colors.white,
              )),
        ),
      ),
    );
  }
}
