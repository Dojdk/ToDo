import 'package:flutter/material.dart';

import '../theme/textstyle.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            textAlign: TextAlign.center,
            'Something went wrong.\nPlease try again later.',
            style: headline,
          ),
          Image.asset(
            'assets/images/png/errorstate.png',
            height: 300,
          ),
        ],
      ),
    );
  }
}
