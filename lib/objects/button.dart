import 'package:flutter/material.dart';

class KataButton extends StatelessWidget {
  const KataButton({Key? key, this.value, this.onclick}) : super(key: key);
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
                fontSize: 45.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
//                            color: Colors.white,
              )),
        ),
      ),
    );
  }
}
