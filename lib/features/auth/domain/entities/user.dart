import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class User {
  final String id;
  final String email;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.name,
  });
}
