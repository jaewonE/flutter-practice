// main.dart
import 'package:flutter/material.dart';
import 'package:flutterpractice/widgets/button.dart';
import 'package:flutterpractice/widgets/currency_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Hey Selena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Welcone back',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '\$5 194 382',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: 'Transfer',
                      bgColor: Color(0xFFF1B33B),
                    ),
                    Button(
                      text: 'Request',
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      bgColor: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Wallets',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'view All',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                CurrencyCard(
                  name: 'Euro',
                  price: '6 428',
                  code: 'EUR',
                  icon: Icons.euro_symbol_sharp,
                ),
                CurrencyCard(
                  name: 'Dollar',
                  price: '55 622',
                  code: 'USD',
                  icon: Icons.attach_money_outlined,
                  offsetY: -20,
                  isDarkTheme: false,
                ),
                CurrencyCard(
                  name: 'Rupee',
                  price: '28 981',
                  code: 'INR',
                  icon: Icons.currency_rupee_outlined,
                  offsetY: -40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
