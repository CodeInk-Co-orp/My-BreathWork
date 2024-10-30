import 'package:flutter/material.dart';
import 'package:my_breath_work/util/colors.dart';

class HomeRow extends StatelessWidget {
  const HomeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){},
          child: const Image(
            image: AssetImage('assets/home_icon.png'),
            width: 40,
            height: 40,
            color: KColors.primaryLight,
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: const Image(
            image: AssetImage('assets/account_icon.png'),
            width: 40,
            height: 40,
            color: KColors.primaryLight,
          ),
        ),
      ],
    );
  }
}