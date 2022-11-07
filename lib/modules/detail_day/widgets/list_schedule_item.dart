import 'package:flutter/material.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';

class ListScheduleItem extends StatelessWidget {
  final ScheduleItem data;

  const ListScheduleItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('card-item-title'),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, 6), blurRadius: 10, spreadRadius: 0)
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(data.title ?? '', style: ThemeText.poppinsRegular.copyWith(fontSize: 20),),
          ),
          const SizedBox(width: 10,),
          const SizedBox(
            height: 24, width: 24,
            child: Icon(Icons.edit_outlined, color: Color(0xffBBBBBB), size: 24,),
          ),
          const SizedBox(width: 23,),
          const SizedBox(
            height: 24, width: 24,
            child: Icon(Icons.delete_outlined, color: Color(0xffBBBBBB), size: 24,),
          )
        ],
      ),
    );
  }
}
