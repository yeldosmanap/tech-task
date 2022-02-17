import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15141F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Произошла ошибка',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontFamily: 'Rubik', fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.064,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.83,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Попробовать снова',
                  style: TextStyle(
                      fontFamily: 'Rubik', fontWeight: FontWeight.w600),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
