// widgets/currency_card.dart
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name;
  final String price;
  final String code;
  final IconData icon;
  final bool isDarkTheme;
  final double offsetX;
  final double offsetY;

  final Color dark = const Color.fromARGB(255, 32, 32, 32);
  final Color light = const Color.fromARGB(255, 249, 249, 249);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.price,
    required this.code,
    required this.icon,
    this.isDarkTheme = true,
    this.offsetX = 0,
    this.offsetY = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isDarkTheme ? dark : light,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isDarkTheme ? light : dark,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: isDarkTheme ? light : dark,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        code,
                        style: TextStyle(
                          color: isDarkTheme
                              ? light.withOpacity(0.7)
                              : dark.withOpacity(0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.5,
                child: Transform.translate(
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: isDarkTheme ? light : dark,
                    size: 80,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
