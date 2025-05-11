import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';

class TodoCard extends StatelessWidget {
  final Item item;
  const TodoCard({super.key, required this.item});

  Color getLabelColor(int idx) {
    switch (idx) {
      case 0:
        return Colors.red;
      case 1:
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    int idx = int.parse(item.id) - 1;
    String dateStr = DateFormat('d MMM', 'en_US').format(item.createdTime).toLowerCase();

    final avatars = item.pic.map((name) {
      return Column(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            child: Text(
              name[0].toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
    }).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 8,
            decoration: BoxDecoration(
              color: getLabelColor(idx),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      dateStr,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...avatars.map((avatar) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: avatar,
          )),
        ],
      ),
    );
  }
} 