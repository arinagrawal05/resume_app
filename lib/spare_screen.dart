import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pryka_labs/experience/add_experience.dart';
import 'package:pryka_labs/projects/add_project.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/projects/project_listtile.dart';
import 'package:pryka_labs/projects/project_model.dart';
import 'package:pryka_labs/utils.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class SparePage extends StatefulWidget {
  final String pagename;

  const SparePage({super.key, required this.pagename});

  @override
  State<SparePage> createState() => _SparePageState();
}

class _SparePageState extends State<SparePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            heading("This is ${widget.pagename} Page", 18, color: Colors.grey),
      ),
    );
  }
}
