import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/projects/project_model.dart';
import 'package:pryka_labs/utils.dart';

// ignore: must_be_immutable
class AddProjectPage extends StatefulWidget {
  String companyid;
  ProjectModel? model;
  AddProjectPage({super.key, required this.companyid, required this.model});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  TextEditingController pheading = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController desc = TextEditingController();

  // late final imageUrl = TextEditingController();

  // final phone = TextEditingController();
  String? imageUrll;

  final projectKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      pheading.text = widget.model!.heading;
      type.text = widget.model!.type;
      link.text = widget.model!.link;
      desc.text = widget.model!.coverLogo;

      imageUrll = widget.model!.coverLogo;
      // imageUrl.text = widget.model!.companyImg;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? modelImage = widget.model == null ? null : widget.model!.coverLogo;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: projectKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                formTextField(
                  pheading,
                  "Project heading*",
                  "e.g. My Cashier App",
                ),

                formTextField(
                  type,
                  "Project type*",
                  "e.g. Fintech",
                ),
                formTextField(
                  link,
                  "Project Link*",
                  "Paste your project link here!",
                ),
                // formTextField(
                //   desc,
                //   "",
                //   "",
                // ),
                descFormTextField(desc, "Description",
                    "Mention your achievements, responsibilities or learnings"),
                heading("Add cover image", 16,
                    fontweight: FontWeight.w600,
                    color: const Color(0xff2E2E2E)),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                      // height: 150,
                      decoration: BoxDecoration(
                        // color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: _pickedImage == null && widget.model == null
                          ? GestureDetector(
                              onTap: () {
                                print("hello");
                                _pickImage(pheading.text);
                              },
                              child: dottedBorder(color: Color(0xffC5C5C5)),
                            )
                          : GestureDetector(
                              onTap: () {
                                _pickImage(pheading.text);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: widget.model == null
                                    ? kIsWeb
                                        ? Image.memory(webImage,
                                            fit: BoxFit.fill)
                                        : Image.file(_pickedImage!,
                                            fit: BoxFit.fill)
                                    : _pickedImage == null
                                        ? Image.network(imageUrll!)
                                        : kIsWeb
                                            ? Image.memory(webImage,
                                                fit: BoxFit.fill)
                                            : Image.file(_pickedImage!,
                                                fit: BoxFit.fill),
                              ),
                            )),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Spacer(),
                isLoading == true
                    ? const CircularProgressIndicator()
                    : Center(
                        child: customButton(
                            widget.model == null
                                ? "Publish"
                                : "Publish Changes", () async {
                          // _selectDate(context);

                          if (projectKey.currentState?.validate() == true) {
                            if (widget.model != null) {
                              // showDatePicker(
                              //   context: context,
                              //   initialDate: DateTime.now(),
                              //   firstDate: DateTime(1900),
                              //   lastDate: DateTime(2101),
                              // );
                              FirebaseFirestore.instance
                                  .collection("Projects")
                                  .doc(widget.companyid)
                                  .update({
                                "heading": pheading.text,
                                "link": link.text,
                                "type": type.text,
                                "description": desc.text,
                                "timestamp": Timestamp.now(),
                                "cover_logo": imageUrll,
                              }).then((value) {
                                Navigator.pop(context);
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("Projects")
                                  .doc(widget.companyid)
                                  .set({
                                "id": widget.companyid,
                                "heading": pheading.text,
                                "link": link.text,
                                "type": type.text,
                                "description": desc.text,
                                "timestamp": Timestamp.now(),
                                "cover_logo": imageUrll,

                                // "phone": dob.text,
                              }).then((value) {
                                print("hello gentle man");

                                Navigator.pop(context);
                              });
                            }
                          }
                        }, context),
                      ),

                // addMemberSheet(context, widget.userid, docId);
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  Future<void> _pickImage(String companyName) async {
    print("object");
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print("object");

      var selected = File(image.path);
      var bytes = await selected.readAsBytes();
      setState(() {
        _pickedImage = selected;
        isLoading = true;
      });
      print("object 2");

      uploadFileToFirebase(fileName: companyName, imageFile: bytes)!
          .then((value) {
        print("object 3");

        setState(() {
          isLoading = false;
          imageUrll = value;
        });
        // print(value);
      });
    } else {
      print('No image has been picked');
    }
  }
}
