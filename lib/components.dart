// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:event_mvp_app/Utils/app_utils.dart';
// import 'package:event_mvp_app/Utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

Widget homeHeading(String text, {bool center = false}) {
  return Text(text,
      textAlign: center ? TextAlign.center : null,
      style: GoogleFonts.poppins(
        color: const Color(0xff1A1A1A),
        fontSize: 24,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ));
}

Widget boldHeading(String text, double fontSize,
    {Color? color = null, bool center = false}) {
  return Text(text,
      textAlign: center ? TextAlign.center : null,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ));
}

Widget heading(String text, double fontSize,
    {Color? color,
    bool center = false,
    FontWeight fontweight = FontWeight.w400}) {
  return Text(text,
      overflow: TextOverflow.clip,
      maxLines: 4,
      textAlign: center ? TextAlign.center : null,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontweight,
        decoration: TextDecoration.none,
      ));
}

Widget heading1(String text, double fontSize,
    {TextOverflow overF = TextOverflow.ellipsis,
    bool center = false,
    Color? color}) {
  return Text(
    text,
    maxLines: 2,
    style: GoogleFonts.nunito(
        color: color ?? Colors.grey,
        fontSize: fontSize,
        fontWeight: FontWeight.w500),
    overflow: overF,
    textAlign: center ? TextAlign.center : TextAlign.justify,
  );
}

Widget productTileText(String text, double fontSize,
    {TextOverflow overF = TextOverflow.ellipsis,
    bool center = false,
    Color? color = null,
    FontWeight fontweight = FontWeight.w500,
    int? maxLines,
    FontStyle? fontStyle}) {
  return Text(
    text,
    softWrap: true,
    overflow: overF,
    maxLines: maxLines,
    textAlign: center ? TextAlign.center : TextAlign.justify,
    style: GoogleFonts.rubik(
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontWeight: fontweight,
        color: color),
  );
}

Widget simpleText(String text, double fontSize,
    {TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.nunito(
      fontSize: fontSize,
    ),
  );
}

Widget boardingButton(
  String text,
  void Function()? ontap,
  BuildContext context, {
  bool isExpanded = true,
  double? height,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
    child: SizedBox(
      height: height,
      width: isExpanded ? double.infinity : null,
      child: ElevatedButton(
        // elevation: 6,
        // style: ButtonStyle(backgroundColor: ),
        // height: ,
        // height: height,

        // minWidth: isExpanded ? MediaQuery.of(context).size.width : null,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(42),
        // ),

        // color: ColorPalatte.secondaryColor2,
        onPressed: ontap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: buttonText(text, 14),
        ),
      ),
    ),
  );
}

Widget customButton(
  String text,
  void Function()? ontap,
  BuildContext context, {
  bool isExpanded = false,
  double? height,
  // Color color = Colors.white,
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 20),
      // height: ,
      height: height,
      minWidth: isExpanded ? MediaQuery.of(context).size.width : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xffF54E44),
      onPressed: ontap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: buttonText(text, 16),
      ),
    ),
  );
}

Widget buttonText(
  String text,
  double fontSize, {
  Color color = const Color(0xffFEF5EA),
}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        color: color, fontSize: fontSize, fontWeight: FontWeight.w700),
  );
}

Widget customCircularLoader(String? term) {
  return Center(
    child: Column(
      children: [
        const CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          strokeWidth: 3,
          // backgroundColor: Colors.grey,
          // color: ColorPalatte.secondaryColor,
        ),
        const SizedBox(
          height: 10,
        ),
        term != null
            ? productTileText(
                term,
                15,
              )
            : Container()
      ],
    ),
  );
}

Widget cachedImage(String companyImg, {String? loaderName}) {
  return
      // Image.network(companyImg);

      CachedNetworkImage(
    imageUrl: companyImg,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
        ),
      ),
    ),
    placeholder: (context, url) => customCircularLoader(loaderName),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Widget infoTag(String term) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    margin: const EdgeInsets.symmetric(
      horizontal: 6,
    ),
    child: Row(
      children: [
        const Icon(
          Icons.check_box,
          color: Color(0xffFEF5EA),
        ),
        const SizedBox(
          width: 10,
        ),
        productTileText(term, 10,
            fontweight: FontWeight.w400, color: const Color(0xffFEF5EA)),
      ],
    ),
  );
}

Widget dateTag(DateTime term) {
  return Container(
    // padding: const EdgeInsets.symmetric(horizontal: 8),
    margin: const EdgeInsets.symmetric(
        // horizontal: 6,
        ),
    child: const Row(
      children: [
        Icon(
          Icons.date_range,
          color: Color(0xffFEF5EA),
          size: 22,
        ),
        SizedBox(
          width: 10,
        ),
        // productTileText(AppUtils.eventDateFormater(term), 14,
        //     fontweight: FontWeight.w400, color: const Color(0xffFEF5EA)),
      ],
    ),
  );
}

Widget customTextfield(
    String hintText, TextEditingController? controller, BuildContext context,
    {void Function(String)? onChanged,
    Widget? prefixIcon,
    bool? enabled,
    int? minLine,
    TextInputType? keyboardType,
    bool isBorderNone = false}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context)
                .buttonTheme
                .colorScheme!
                .inversePrimary
                .withOpacity(0.2),
          ),
          height: minLine == null ? 44 : 25 * minLine.toDouble(),
          child: TextField(
            // minLines: 2,
            maxLines: minLine,
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            // controller: _phoneController,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              // decoration: const InputDecoration(),
              // border:,
              // prefixIcon: Padding(
              //   padding:
              //       const EdgeInsets.only(top: 12, left: 10),
              //   child: productTileText("+91 ", 14,
              //       color: Colors.black),
              // ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              border: isBorderNone
                  ? InputBorder.none
                  : const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(width: 0),
                    ),
              // minLines: 1,
              // maxLines: 1,
              // style: GoogleFonts.montserrat(
              // color: Colors.black,
              // fontWeight: FontWeight.w400,
              // fontSize: 14),
            ),
          ),
        ),
      ));
}

Widget actionCircularAvatar(IconData icondata, BuildContext context, ontap) {
  return GestureDetector(
      onTap: ontap,
      child: CircleAvatar(
        radius: 26,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icondata,
            size: 20,
          ),
        ),
      ));
}

Widget countBlock(
  int number,
  String label,
  BuildContext context, {
  bool isContact = false,
}) {
  // final display = createDisplay(
  //   length: 4,
  //   decimal: 0,
  // );
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
    // height: 100,
    alignment: Alignment.center,
    child: Column(
      children: [
        isContact
            ? const Icon(
                Ionicons.person_outline,
                color: Colors.black,
                size: 20,
              )
            : Text(
                number.toString(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
        const SizedBox(
          height: 4,
        ),
        Text(isContact ? "Contacts" : label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color(0xff6B6B6B)))
      ],
    ),
  );
}

Widget descCustomTextfield(String hintText, TextEditingController? controller,
    {void Function(String)? onChanged,
    Widget? prefixIcon,
    bool? enabled,
    int? minLine,
    TextInputType? keyboardType,
    bool isBorderNone = true}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Color(0xff0F1015).withOpacity(0.04),
        ),
        height: 197,
        child: TextField(
          minLines: 2,
          maxLines: 2,
          controller: controller,
          // enabled: enabled,
          // keyboardType: keyboardType,
          // controller: _phoneController,
          // onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff2A2A2A).withOpacity(0.5)),
            // prefixIcon: prefixIcon,
            // decoration: const InputDecoration(),
            // border:,
            // prefixIcon: Padding(
            //   padding:
            //       const EdgeInsets.only(top: 12, left: 10),
            //   child: productTileText("+91 ", 14,
            //       color: Colors.black),
            // ),

            contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            border: isBorderNone
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 0),
                  ),
            // minLines: 1,
            // maxLines: 1,
            // style: GoogleFonts.montserrat(
            // color: Colors.black,
            // fontWeight: FontWeight.w400,
            // fontSize: 14),
          ),
        ),
      ));
}

Widget descFormTextField(
    TextEditingController controller, String labelText, String placeText,
    {bool isCompulsory = true,
    Function(String)? onChange,
    bool isAbsorbed = false,
    TextInputType? kType = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 12,
    ),
    child: AbsorbPointer(
      absorbing: isAbsorbed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading(labelText, 16,
              fontweight: FontWeight.w600, color: const Color(0xff2E2E2E)),
          descCustomTextfield(placeText, controller)
        ],
      ),
    ),
  );
}

Widget formTextField(
    TextEditingController controller, String labelText, String placeText,
    {bool isCompulsory = true,
    Function(String)? onChange,
    bool isAbsorbed = false,
    TextInputType? kType = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 12,
    ),
    child: AbsorbPointer(
      absorbing: isAbsorbed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading(labelText, 16,
              fontweight: FontWeight.w600, color: const Color(0xff2E2E2E)),
          Container(
            child: TextFormField(
              onChanged: onChange,
              keyboardType: kType,
              controller: controller,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Color(0xffE7E7E7)),
                ),
                // labelText: 'Enter your text',

                // errorText: "Please Enter " + labelText,
                // border: OutlineInputBorder(

                // borderRadius: BorderRadius.circular(12),
                // ),
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffB1B1B1)),
                hintText: placeText,
                isDense: true,

                contentPadding: const EdgeInsets.only(bottom: 17, top: 1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget dottedBorder({
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DottedBorder(
        dashPattern: const [6.7],
        // borderType: BorderType.RRect,
        color: color,
        strokeCap: StrokeCap.round,
        radius: const Radius.circular(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12,
              ),
              Icon(
                Icons.cloud_upload_outlined,
                color: color,
                size: 50,
              ),
              TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffE6E6E6)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff797979)),
                  ),
                  onPressed: (() {}),
                  child: productTileText(
                    'Browse Files',
                    13,
                    fontweight: FontWeight.w400,
                    color: Color(0xff797979),
                  )),
              productTileText('Tap here to pick cover Image', 10,
                  fontweight: FontWeight.w400, color: Color(0xff7C5C5C5)),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        )),
  );
}
