// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> fromMap() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      topics: List<String>.from((map['topics'] as List<String>),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }


}
