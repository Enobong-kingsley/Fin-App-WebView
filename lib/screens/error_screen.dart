import 'package:flutter/material.dart';

import 'home_screen_ui.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/error_img.jpg"),
                Text(
                  'Error loading page!',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
