import 'package:flutter/material.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';

class ListScheduleItem extends StatelessWidget {
  final ScheduleItem data;
  final Function() onEditTap;
  final Function() onDeleteTap;

  const ListScheduleItem({Key? key, required this.onEditTap, required this.onDeleteTap, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            child: Text(data.title ?? '', key: const Key('card-item-title'), style: ThemeText.poppinsRegular.copyWith(fontSize: 16),),
          ),
          const SizedBox(width: 10,),
          GestureDetector(
            key: const Key('card-item-edit'),
            onTap: () => onEditTap(),
            child: const SizedBox(
              height: 24, width: 24,
              child: Icon(Icons.edit_outlined, color: Color(0xffBBBBBB), size: 24,),
            ),
          ),
          const SizedBox(width: 16,),
          GestureDetector(
            key: const Key('card-item-delete'),
            onTap: () => onDeleteTap(),
            child: const SizedBox(
              height: 24, width: 24,
              child: Icon(Icons.delete_outlined, color: Color(0xffBBBBBB), size: 24,),
            ),
          )
        ],
      ),
    );
  }
}
