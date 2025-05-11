import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/board_data.dart';
import '../models/board.dart';
import '../models/item.dart';
import '../widgets/todo_card.dart';

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
                title: Text(boards[i].boardName),
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

  void _moveItemToBoard(Item item, int fromBoardIdx, int toBoardIdx) {
    setState(() {
      boards[fromBoardIdx].items.remove(item);
      boards[toBoardIdx].items.add(item);
    });
  }

  void _showItemDetail(Item item, int fromBoardIdx) {
    int selectedStatusIdx = fromBoardIdx;
    bool showComments = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        String dateStr = DateFormat('d MMM yyyy, HH:mm', 'en_US').format(item.createdTime);
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
                    Text(item.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(item.description, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('Submitter: ${item.submitter}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (item.pic.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          'PIC: ' + item.pic.join(', '),
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
                    if (item.comments.isNotEmpty) ...[
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
                            for (final c in item.comments)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${c.user}: ',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Text(c.text)),
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
                            child: Text(boards[i].boardName),
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
                      board.boardName,
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
                if (board.items.isEmpty)
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
                  ...board.items.map((item) => GestureDetector(
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