import 'package:flutter/material.dart';


class Buttons extends StatelessWidget {
  final void Function() action;
  final String title;

  const Buttons({
    required this.action, this.title = ''
  });

  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: action,
        child: Container(
          height: height * 0.06,
          width: width * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
           color: Theme.of(context).colorScheme.secondary,
            
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     blurRadius: 10,
              //   ),
              // ]
              ),
          child: Center(
              child: Text(
        title,
            style: TextStyle(color: Colors.white, fontSize: height * 0.02),
          )),
        ),
      ),
    );
  }
}