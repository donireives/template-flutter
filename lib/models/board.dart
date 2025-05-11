import 'item.dart';

class Board {
  final String boardId;
  final String boardName;
  final List<Item> items;

  Board({
    required this.boardId,
    required this.boardName,
    required this.items,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardId: json['board_id'],
      boardName: json['board_name'],
      items: (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'board_id': boardId,
      'board_name': boardName,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
} 