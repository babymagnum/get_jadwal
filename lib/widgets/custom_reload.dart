import 'package:flutter/material.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';

class CustomReload extends StatelessWidget {
  final Function onTap;

  const CustomReload({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          const Icon(Icons.refresh, size: 20, color: Colors.black45,),
          const SizedBox(height: 10,),
          Text('Tap to reload.', style: ThemeText.poppinsSemiBold.copyWith(fontSize: 16, color: Colors.black26),)
        ],
      ),
    );
  }
}
