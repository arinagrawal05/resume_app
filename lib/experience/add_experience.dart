import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/experience/experience_model.dart';
import 'package:pryka_labs/components.dart';
import 'package:pryka_labs/utils.dart';

// ignore: must_be_immutable
class AddExperiencePage extends StatefulWidget {
  String companyid;
  ExperienceModel? model;
  AddExperiencePage({super.key, required this.companyid, required this.model});

  @override
  State<AddExperiencePage> createState() => _AddExperiencePageState();
}

class _AddExperiencePageState extends State<AddExperiencePage> {
  TextEditingController role = TextEditingController();
  TextEditingController link = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  // late final imageUrl = TextEditingController();

  // final phone = TextEditingController();
  String? imageUrll;
  // bool isPresent = false;
  final List<String> titleList = [
    'Hair Stylist',
    'Makeup Artist',
    'Dressing Artist',
    'Clothing Artist',
  ];

  final List<String> locationList = [
    'Kolkata',
    'Mumbai',
    'Delhi',
    'Banglore',
  ];
  final List<String> companyList = [
    'Gucci',
    'Louis Vuitton',
    'Armani',
    'Zara',
  ];
  bool isPresent = false;
  String? selectedCompany;
  String? selectedTitle;
  String? selectedLocation;
  String jobType = "Pending";

  final list1 = ["Internship", "Full time"];
  final list2 = ["Freelance", "Self-lead"];
  final experienceKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      jobType = widget.model!.type;
      selectedCompany = widget.model!.companyName;
      selectedTitle = widget.model!.title;
      selectedLocation = widget.model!.location;
      link.text = widget.model!.link;
      role.text = widget.model!.role;
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
            widget.model == null ? "Add work Experience" : "Update Experience",
            16,
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
                heading("Job type*", 16,
                    fontweight: FontWeight.w600,
                    color: const Color(0xff2E2E2E)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      // height: 50.0,
                      child: RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: jobType,
                        horizontalAlignment: MainAxisAlignment.start,
                        onChanged: (value) => setState(() {
                          jobType = value ?? '';
                        }),
                        items: list1,
                        fillColor: Colors.black,
                        activeColor: Colors.black,
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 50.0,
                      child: RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: jobType,
                        horizontalAlignment: MainAxisAlignment.end,
                        onChanged: (value) => setState(() {
                          jobType = value ?? '';
                        }),
                        items: list2,
                        fillColor: Colors.black,
                        activeColor: Colors.black,
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ),
                  ],
                ),
                // formTextField(
                //   title,
                //   "Job title",
                //   "e.g. Assistant manager",
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xffE7E7E7),
                  ),
                ),
                dropdownGroup("Job Title*", 'eg: Fashion Stylist',
                    selectedTitle, titleList, (String? value) {
                  setState(() {
                    selectedTitle = value;
                  });
                }),

                dropdownGroup("Company/stylist name*", 'eg: Gucci',
                    selectedCompany, companyList, (String? value) {
                  setState(() {
                    selectedCompany = value;
                  });
                }),
                dropdownGroup("Job location*", 'eg: Mumbai', selectedLocation,
                    locationList, (String? value) {
                  setState(() {
                    selectedLocation = value;
                  });
                }),

                GestureDetector(
                  onTap: () => selectStartDate(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      heading("Start Date*", 16,
                          fontweight: FontWeight.w600,
                          color: const Color(0xff2E2E2E)),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          startDate == null
                              ? heading("DD", 14,
                                  fontweight: FontWeight.w400,
                                  color: Color(0xffAEAEAE))
                              : heading(
                                  startDate!.day.toString().padLeft(2, '0'), 14,
                                  fontweight: FontWeight.w500,
                                  color: Color(0xff030303)),
                          heading(" / ", 14,
                              fontweight: FontWeight.w500,
                              color: Color(0xff030303)),
                          startDate == null
                              ? heading("MM", 14,
                                  fontweight: FontWeight.w400,
                                  color: Color(0xffAEAEAE))
                              : heading(
                                  startDate!.month.toString().padLeft(2, '0'),
                                  14,
                                  fontweight: FontWeight.w500,
                                  color: Color(0xff030303)),
                          heading(" / ", 14,
                              fontweight: FontWeight.w500,
                              color: Color(0xff030303)),
                          startDate == null
                              ? heading("YYYY", 14,
                                  fontweight: FontWeight.w400,
                                  color: Color(0xffAEAEAE))
                              : heading(
                                  startDate!.year.toString().padLeft(2, '0'),
                                  14,
                                  fontweight: FontWeight.w500,
                                  color: Color(0xff030303)),
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
                                              color: Color(0xffAEAEAE))
                                          : heading(
                                              endDate!.day
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              14,
                                              fontweight: FontWeight.w500,
                                              color: Color(0xff030303)),
                                      heading(" / ", 14,
                                          fontweight: FontWeight.w500,
                                          color: Color(0xff030303)),
                                      endDate == null
                                          ? heading("MM", 14,
                                              fontweight: FontWeight.w400,
                                              color: Color(0xffAEAEAE))
                                          : heading(
                                              endDate!.month
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              14,
                                              fontweight: FontWeight.w500,
                                              color: Color(0xff030303)),
                                      heading(" / ", 14,
                                          fontweight: FontWeight.w500,
                                          color: Color(0xff030303)),
                                      endDate == null
                                          ? heading("YYYY", 14,
                                              fontweight: FontWeight.w400,
                                              color: Color(0xffAEAEAE))
                                          : heading(
                                              endDate!.year
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              14,
                                              fontweight: FontWeight.w500,
                                              color: Color(0xff030303)),
                                      // Text(DateFormat('MMMM yyyy').format(startDate))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
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
                              color: Color(0xff030303)),
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
                SizedBox(
                  height: 8,
                ),
                formTextField(
                  link,
                  "Project Link",
                  "This link will be displayed next to this experience!",
                ),

                descFormTextField(role, "Description",
                    "Mention your achievements, responsibilities or learnings"),

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
                                _pickImage(selectedTitle ??
                                    Timestamp.now()
                                        .microsecondsSinceEpoch
                                        .toString());
                              },
                              child:
                                  dottedBorder(color: const Color(0xffC5C5C5)),
                            )
                          : GestureDetector(
                              onTap: () {
                                _pickImage(selectedTitle ??
                                    Timestamp.now()
                                        .microsecondsSinceEpoch
                                        .toString());
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
                          if (startDate == null &&
                              endDate == null &&
                              selectedCompany == null &&
                              selectedLocation == null &&
                              selectedTitle == null &&
                              imageUrll == null) {
                            showToast(context, "Please Fill all Details");
                          } else {
                            if (experienceKey.currentState?.validate() ==
                                true) {
                              if (widget.model != null) {
                                // showDatePicker(
                                //   context: context,
                                //   initialDate: DateTime.now(),
                                //   firstDate: DateTime(1900),
                                //   lastDate: DateTime(2101),
                                // );
                                FirebaseFirestore.instance
                                    .collection("Experience")
                                    .doc(widget.companyid)
                                    .update({
                                  "title": selectedTitle,
                                  "role": role.text,
                                  "type": jobType,
                                  "timestamp": Timestamp.now(),
                                  "start_date": startDate,
                                  "end_date": endDate,
                                  "isPresent": isPresent,
                                  "company_name": selectedCompany,
                                  "link": link.text,
                                  "location": selectedLocation,
                                  "cover_logo": imageUrll, // "phone": dob.text,
                                }).then((value) {
                                  Navigator.pop(context);
                                });
                              } else {
                                FirebaseFirestore.instance
                                    .collection("Experience")
                                    .doc(widget.companyid)
                                    .set({
                                  "id": widget.companyid,
                                  "title": selectedTitle,
                                  "role": role.text,
                                  "type": jobType,

                                  "timestamp": Timestamp.now(),
                                  "start_date": startDate,
                                  "end_date": endDate,
                                  "isPresent": isPresent,
                                  "location": selectedLocation,

                                  "company_name": selectedCompany,
                                  "link": link.text,
                                  "cover_logo": imageUrll,
                                  // "phone": dob.text,
                                }).then((value) {
                                  print("hello gentle man");

                                  Navigator.pop(context);
                                });
                              }
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

  Column dropdownGroup(String labelText, String hintText, String? myValue,
      List<String> list, void Function(String?)? onChanged) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading(labelText, 16,
            fontweight: FontWeight.w600, color: const Color(0xff2E2E2E)),
        Container(
          child: DropdownButton2<String>(
            underline: const Divider(
              thickness: 1,
              color: Color(0xffE7E7E7),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Ionicons.chevron_down,
                color: Color(0xff0B1C3F),
              ),
            ),
            isExpanded: true,
            hint: heading(hintText, 14, color: const Color(0xffB1B1B1)),
            items: list
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: heading(
                        item,
                        14,
                        fontweight: FontWeight.w400,
                      ),
                    ))
                .toList(),
            value: myValue,
            onChanged: onChanged,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
            buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(

                    // border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(12))),
            menuItemStyleData: const MenuItemStyleData(

                // height: 40,
                ),
          ),
        ),
      ],
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

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Adjust the duration as needed
    ),
  );
}
