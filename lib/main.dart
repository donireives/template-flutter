import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

// Data JSON hardcode
const List<Map<String, dynamic>> boards = [
  {
    "board_id": "1",
    "board_name": "Need to do",
    "items": [
      {
        "id": "1",
        "name": "To do reserch",
        "description": "test to do reserch blablabla",
        "submitter": "tyto",
        "pic": ["davit", "fathul"],
        "created_time": "2025-05-10T08:08:08",
        "comments": [
          {"user": "tyto", "text": "segera kerjakan"},
          {"user": "fathul", "text": "besok, karena saya masih di project lain"}
        ]
      },
      {
        "id": "2",
        "name": "Design UI for dashboard",
        "description": "Create wireframes and UI design for admin dashboard",
        "submitter": "tyto",
        "pic": ["fathul"],
        "created_time": "2025-05-10T10:00:00",
        "comments": [
          {"user": "fathul", "text": "akan saya mulai hari ini"}
        ]
      },
      {
        "id": "3",
        "name": "Prepare API documentation",
        "description": "Write API specs for internal use",
        "submitter": "tyto",
        "pic": ["fathul"],
        "created_time": "2025-05-10T11:30:00",
        "comments": []
      }
    ]
  },
  {
    "board_id": "2",
    "board_name": "OnProcess",
    "items": [
      {
        "id": "4",
        "name": "Implement authentication",
        "description": "Add login and registration with JWT",
        "submitter": "tyto",
        "pic": ["fathul"],
        "created_time": "2025-05-10T09:15:00",
        "comments": [
          {"user": "fathul", "text": "sudah mulai coding"}
        ]
      }
    ]
  },
  {
    "board_id": "3",
    "board_name": "Finish",
    "items": []
  }
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Redesign',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TodoBoardPage(),
    );
  }
}

class TodoBoardPage extends StatefulWidget {
  const TodoBoardPage({super.key});

  @override
  State<TodoBoardPage> createState() => _TodoBoardPageState();
}

class _TodoBoardPageState extends State<TodoBoardPage> {
  int selectedBoardIndex = 0;

  void _showBoardSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            for (int i = 0; i < boards.length; i++)
              ListTile(
                title: Text(boards[i]['board_name']),
                selected: i == selectedBoardIndex,
                onTap: () {
                  setState(() {
                    selectedBoardIndex = i;
                  });
                  Navigator.pop(context);
                },
              ),
          ],
        );
      },
    );
  }

  // Tambahkan fungsi untuk memindahkan item antar board
  void _moveItemToBoard(Map<String, dynamic> item, int fromBoardIdx, int toBoardIdx) {
    setState(() {
      (boards[fromBoardIdx]['items'] as List).remove(item);
      (boards[toBoardIdx]['items'] as List).add(item);
    });
  }

  void _showItemDetail(Map<String, dynamic> item, int fromBoardIdx) {
    int selectedStatusIdx = fromBoardIdx;
    bool showComments = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        DateTime date = DateTime.parse(item['created_time']);
        String dateStr = DateFormat('d MMM yyyy, HH:mm', 'en_US').format(date);
        final avatars = (item['pic'] as List).map((name) {
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
        final comments = item['comments'] as List?;
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(item['description'] ?? '-', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('Submitter: ${item['submitter']}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if ((item['pic'] as List).isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          'PIC: ' + (item['pic'] as List).join(', '),
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(dateStr),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Komentar
                    if (comments != null && comments.isNotEmpty) ...[
                      TextButton.icon(
                        onPressed: () {
                          setModalState(() {
                            showComments = !showComments;
                          });
                        },
                        icon: Icon(showComments ? Icons.expand_less : Icons.expand_more),
                        label: Text(showComments ? 'Sembunyikan komentar' : 'Lihat komentar'),
                      ),
                      if (showComments)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final c in comments)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${c['user']}: ',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Text(c['text'])),
                                  ],
                                ),
                              ),
                          ],
                        ),
                    ],
                    const SizedBox(height: 16),
                    const Text('Ubah Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<int>(
                      value: selectedStatusIdx,
                      items: [
                        for (int i = 0; i < boards.length; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(boards[i]['board_name']),
                          ),
                      ],
                      onChanged: (val) {
                        setModalState(() {
                          selectedStatusIdx = val!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedStatusIdx == fromBoardIdx
                                ? null
                                : () {
                                    _moveItemToBoard(item, fromBoardIdx, selectedStatusIdx);
                                    Navigator.pop(context);
                                  },
                            child: const Text('Pindahkan'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final board = boards[selectedBoardIndex];
    final items = board['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kanban app', style: TextStyle(fontSize: 18)),
            Text('doni was here', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.notifications_none),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      board['board_name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: _showBoardSelector,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        'Tidak ada item',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                else
                  ...items.map((item) => GestureDetector(
                        onTap: () => _showItemDetail(item, selectedBoardIndex),
                        child: TodoCard(item: item),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const TodoCard({super.key, required this.item});

  Color getLabelColor(int idx) {
    // Warna label sesuai urutan pada gambar
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
    int idx = int.parse(item['id']) - 1;
    DateTime date = DateTime.parse(item['created_time']);
    String dateStr = DateFormat('d MMM', 'en_US').format(date).toLowerCase();

    // Avatar dummy
    final avatars = (item['pic'] as List).map((name) {
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
          // Label warna
          Container(
            width: 36,
            height: 8,
            decoration: BoxDecoration(
              color: getLabelColor(idx),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          // Konten utama
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
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
          // Avatar PIC
          ...avatars.map((avatar) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: avatar,
          )),
        ],
      ),
    );
  }
}
