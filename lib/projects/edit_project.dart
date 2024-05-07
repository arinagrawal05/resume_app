import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/experience/add_experience.dart';
import 'package:pryka_labs/projects/add_project.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/edit_avatar.dart';
import 'package:pryka_labs/projects/project_listtile.dart';
import 'package:pryka_labs/projects/project_model.dart';
import 'package:pryka_labs/utils.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class EditProjectPage extends StatefulWidget {
  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Ionicons.close)),
        elevation: 0,
        title: heading("Edit Project", 16, fontweight: FontWeight.w500),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Projects")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data!.docs.isEmpty) {
                      return GestureDetector(
                        onTap: () {
                          var uuid = Uuid().v4();
                          AppUtils.navigate(
                              AddProjectPage(companyid: uuid, model: null),
                              context);
                        },
                        child: Row(children: [
                          buildEditableAvatar(),
                          const SizedBox(
                            width: 10,
                          ),
                          heading("Add your first work experience", 14,
                              fontweight: FontWeight.w600),
                        ]),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return customCircularLoader("Projects");
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            // return Text("erfdfv");
                            ProjectModel model = ProjectModel.fromFirestore(
                                snapshot.data!.docs[index]);
                            return ProjectListTile(
                                model: model, context: context);
                          });
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
