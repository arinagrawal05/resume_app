import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/education/education_model.dart';

import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/utils.dart';

// ignore: must_be_immutable
class AddEducationPage extends StatefulWidget {
  String companyid;
  EducationModel? model;
  AddEducationPage({super.key, required this.companyid, required this.model});

  @override
  State<AddEducationPage> createState() => _AddEducationPageState();
}

class _AddEducationPageState extends State<AddEducationPage> {
  TextEditingController institute = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController degreeName = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  // late final imageUrl = TextEditingController();

  // final phone = TextEditingController();
  String? imageUrll;
  bool isPresent = false;

  final experienceKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      institute.text = widget.model!.institute;
      location.text = widget.model!.location;
      degreeName.text = widget.model!.degree;
      isPresent = widget.model!.isPresent;

      startDate = widget.model!.startDate.toDate();

      endDate = widget.model!.endDate.toDate();

      imageUrll = widget.model!.coverLogo;
      // imageUrl.text = widget.model!.companyImg;
    }
  }

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
        title: heading(
            widget.model == null ? "Add Education" : "Update Education", 16,
            fontweight: FontWeight.w500),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: experienceKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formTextField(
                  institute,
                  "Institute Name",
                  "e.g. Mumbai University",
                ),
                formTextField(
                  degreeName,
                  "Degree name",
                  "Btech, CSE",
                ),
                formTextField(
                  location,
                  "Location",
                  "e.g. Green square, Mumbai",
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () => selectStartDate(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      heading("Start Date*", 16,
                          fontweight: FontWeight.w600,
                          color: const Color(0xff2E2E2E)),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          startDate == null
                              ? heading("DD", 14,
                                  fontweight: FontWeight.w400,
                                  color: const Color(0xffAEAEAE))
                              : heading(
                                  startDate!.day.toString().padLeft(2, '0'), 14,
                                  fontweight: FontWeight.w500,
                                  color: const Color(0xff030303)),
                          heading(" / ", 14,
                              fontweight: FontWeight.w500,
                              color: const Color(0xff030303)),
                          startDate == null
                              ? heading("MM", 14,
                                  fontweight: FontWeight.w400,
                                  color: const Color(0xffAEAEAE))
                              : heading(
                                  startDate!.month.toString().padLeft(2, '0'),
                                  14,
                                  fontweight: FontWeight.w500,
                                  color: const Color(0xff030303)),
                          heading(" / ", 14,
                              fontweight: FontWeight.w500,
                              color: const Color(0xff030303)),
                          startDate == null
                              ? heading("YYYY", 14,
                                  fontweight: FontWeight.w400,
                                  color: const Color(0xffAEAEAE))
                              : heading(
                                  startDate!.year.toString().padLeft(2, '0'),
                                  14,
                                  fontweight: FontWeight.w500,
                                  color: const Color(0xff030303)),
                          // Text(DateFormat('MMMM yyyy').format(startDate))
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xffE7E7E7),
                  ),
                ),
                GestureDetector(
                  onTap: () => selectEndDate(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      heading("End Date*", 16,
                          fontweight: FontWeight.w600,
                          color: const Color(0xff2E2E2E)),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.black,
                            value: false,
                            groupValue: isPresent,
                            onChanged: (value) {
                              setState(() {
                                isPresent = value!;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      endDate == null
                                          ? heading("DD", 14,
                                              fontweight: FontWeight.w400,
                                              color: const Color(0xffAEAEAE))
                                          : heading(
                                              endDate!.day
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              14,
                                              fontweight: FontWeight.w500,
                                              color: const Color(0xff030303)),
                                      heading(" / ", 14,
                                          fontweight: FontWeight.w500,
                                          color: const Color(0xff030303)),
                                      endDate == null
                                          ? heading("MM", 14,
                                              fontweight: FontWeight.w400,
                                              color: const Color(0xffAEAEAE))
                                          : heading(
                                              endDate!.month
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              14,
                                              fontweight: FontWeight.w500,
                                              color: const Color(0xff030303)),
                                      heading(" / ", 14,
                                          fontweight: FontWeight.w500,
                                          color: const Color(0xff030303)),
                                      endDate == null
                                          ? heading("YYYY", 14,
                                              fontweight: FontWeight.w400,
                                              color: const Color(0xffAEAEAE))
                                          : heading(
                                              endDate!.year
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              14,
                                              fontweight: FontWeight.w500,
                                              color: const Color(0xff030303)),
                                      // Text(DateFormat('MMMM yyyy').format(startDate))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Radio(
                            activeColor: Colors.black,
                            value: true,
                            groupValue: isPresent,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                isPresent = value!;
                              });
                            },
                          ),
                          heading("Present ", 14,
                              fontweight: FontWeight.w500,
                              color: const Color(0xff030303)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xffE7E7E7),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                heading("Cover Logo", 18, fontweight: FontWeight.w600),
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
                                _pickImage(institute.text);
                              },
                              child:
                                  dottedBorder(color: const Color(0xffC5C5C5)),
                            )
                          : GestureDetector(
                              onTap: () {
                                _pickImage(institute.text);
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
                  height: 70,
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

                          if (experienceKey.currentState?.validate() == true) {
                            if (widget.model != null) {
                              // showDatePicker(
                              //   context: context,
                              //   initialDate: DateTime.now(),
                              //   firstDate: DateTime(1900),
                              //   lastDate: DateTime(2101),
                              // );
                              FirebaseFirestore.instance
                                  .collection("Education")
                                  .doc(widget.companyid)
                                  .update({
                                "institute": institute.text,
                                "degree": degreeName.text,
                                "location": location.text,
                                "timestamp": Timestamp.now(),
                                "start_date": startDate,
                                "end_date": endDate,
                                "isPresent": isPresent,
                                "cover_logo": imageUrll,

                                // "phone": dob.text,
                              }).then((value) {
                                Navigator.pop(context);
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("Education")
                                  .doc(widget.companyid)
                                  .set({
                                "id": widget.companyid,
                                "institute": institute.text,
                                "degree": degreeName.text,
                                "location": location.text,
                                "timestamp": Timestamp.now(),
                                "start_date": startDate,
                                "end_date": endDate,
                                "isPresent": isPresent,
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

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }
}
