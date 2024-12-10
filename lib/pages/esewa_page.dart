import 'package:flutter/material.dart';
import 'package:price_check_np/Esewa Functions/esewa.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/appbar.dart';

class EsewaScreen extends StatelessWidget {
  const EsewaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: true,
      ),
      body: Center( 
        child: ListView(
          
          padding: const EdgeInsets.all(24.0),
          children: [
            const SizedBox(height: 20), 
            MyButton( 
              onPressed: () {
                Esewa esewa = Esewa();
                esewa.pay();
              },
              buttontext: 'Donate Us Through Esewa',
            ),
          ],
        ),
      ),
    );
  }
}
