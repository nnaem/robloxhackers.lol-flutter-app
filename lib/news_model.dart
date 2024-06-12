import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String id;
  final String title;
  final Timestamp date;
  final bool pinned;
  final String content;

  News({
    required this.id,
    required this.title,
    required this.date,
    required this.pinned,
    required this.content,
  });

  factory News.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return News(
      id: doc.id,
      title: data['title'] ?? '',
      date: data['date'],
      pinned: data['pinned'] ?? false,
      content: data['content'] ?? '',
    );
  }
}
