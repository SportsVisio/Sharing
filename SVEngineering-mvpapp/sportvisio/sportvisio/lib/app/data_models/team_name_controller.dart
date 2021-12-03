import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TeamNameAndController {
  late String? name;
  late TextEditingController controller;
  late Uuid id;

  TeamNameAndController({this.name, required this.controller,required this.id});
}
