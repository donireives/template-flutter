import '../models/board.dart';
import '../models/item.dart';

final List<Board> boards = [
  Board(
    boardId: "1",
    boardName: "Need to do",
    items: [
      Item(
        id: "1",
        name: "To do reserch",
        description: "test to do reserch blablabla",
        submitter: "tyto",
        pic: ["davit", "fathul"],
        createdTime: DateTime.parse("2025-05-10T08:08:08"),
        comments: [
          Comment(user: "tyto", text: "segera kerjakan"),
          Comment(user: "fathul", text: "besok, karena saya masih di project lain"),
        ],
      ),
      Item(
        id: "2",
        name: "Design UI for dashboard",
        description: "Create wireframes and UI design for admin dashboard",
        submitter: "tyto",
        pic: ["fathul"],
        createdTime: DateTime.parse("2025-05-10T10:00:00"),
        comments: [
          Comment(user: "fathul", text: "akan saya mulai hari ini"),
        ],
      ),
      Item(
        id: "3",
        name: "Prepare API documentation",
        description: "Write API specs for internal use",
        submitter: "tyto",
        pic: ["fathul"],
        createdTime: DateTime.parse("2025-05-10T11:30:00"),
        comments: [],
      ),
    ],
  ),
  Board(
    boardId: "2",
    boardName: "OnProcess",
    items: [
      Item(
        id: "4",
        name: "Implement authentication",
        description: "Add login and registration with JWT",
        submitter: "tyto",
        pic: ["fathul"],
        createdTime: DateTime.parse("2025-05-10T09:15:00"),
        comments: [
          Comment(user: "fathul", text: "sudah mulai coding"),
        ],
      ),
    ],
  ),
  Board(
    boardId: "3",
    boardName: "Finish",
    items: [],
  ),
]; 