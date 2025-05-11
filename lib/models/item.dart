class Item {
  final String id;
  final String name;
  final String description;
  final String submitter;
  final List<String> pic;
  final DateTime createdTime;
  final List<Comment> comments;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.submitter,
    required this.pic,
    required this.createdTime,
    required this.comments,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      submitter: json['submitter'],
      pic: List<String>.from(json['pic']),
      createdTime: DateTime.parse(json['created_time']),
      comments: (json['comments'] as List).map((c) => Comment.fromJson(c)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'submitter': submitter,
      'pic': pic,
      'created_time': createdTime.toIso8601String(),
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
}

class Comment {
  final String user;
  final String text;

  Comment({
    required this.user,
    required this.text,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: json['user'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'text': text,
    };
  }
} 