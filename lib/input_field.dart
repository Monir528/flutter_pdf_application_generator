import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// import 'package:pdf_flutter/pdf_flutter.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class InputField extends StatelessWidget {

  // Global variables
  // const InputField({Key? key}) : super(key: key);
  String? value;
  String copyPath = '';
  InputField( this.value );
  final formKey = GlobalKey<FormState>();
  var questionList = {
      'Job Application Letter' : ['Address','Advertised Platform','Advertising Date','Year\'s of Experience', 'Previous Job Position','Previous Company Name', 'Previous Job Location', 'Wishing Company Name', 'Applicant Name'],
      'Category1' : ['Name','Section','Department'],
      'Category2' : ['Name','Section','Department', 'Problems'],
    };
  var data = {};

  final doc = pw.Document();


  // build widget tree
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ...(questionList[value] as List<String>).map((e) => inputWidget(e)),
            Container(
              padding: EdgeInsets.all(30),
              child: _button("GENERATE", () async {
                if(formKey.currentState!.validate()){
                    formKey.currentState?.save();
                    print(data);

                    // generating dpf
                    doc.addPage(pw.Page(
                      build: (pw.Context context) {
                        return _designTemplate();
                      }
                    ));


                    final output = await getExternalStorageDirectory();
                    String copyPath = output.path + '/'+data['Applicant Name']+'_new_document.pdf';
                    File file = File(copyPath);
                    print(copyPath);
                    await file.writeAsBytes(await doc.save());
                    copyPath = file.path;
                    print(copyPath);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }


  //Pdf template design
  pw.Container _designTemplate(){
    return pw.Container(
      child: pw.Column(
        children: [
          pw.Container(
            margin: const pw.EdgeInsets.only(
              bottom: 40
            ),
            alignment: pw.Alignment.center,
            child: pw.Text(
              "Job Application",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold
              )
            ),
          ),
          pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              "Subject: Job Application\n\n"
                  +"Dear,\n\n"
                  +data['Wishing Company Name']+" Manager\n\n"
                  +data['Address']+"\n",
            )
          ),
          pw.Container(
            alignment: pw.Alignment.centerLeft,
            margin: const pw.EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            child: pw.Text(
              "With Regards,"
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(
              bottom: 20,
            ),
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                "Herewith I send application letter and curriculum vitae in response to your advertising in the "
                    +data['Advertised Platform']+", "+data['Advertising Date']
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(
              bottom: 20,
            ),
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                "I have had experience over the past "+data['Year\'s of Experience']+" years as "+data['Previous Job Position']+" at "+data['Previous Company Name']+". In that position I\'m responsible for sales in the "+data['Previous Job Location']+"."
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(
              bottom: 30,
            ),
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                "I realize that your resume or curriculum vitae that I submit this can not explain my qualifications in depth. Therefore, I really hope there is a chance interview, which I can explain how the potential in me and my ministry will give will be a tremendous asset for PT's "+data['Wishing Company Name']+"."
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(
              bottom: 30,
            ),
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                "Sincerely,"
            ),
          ),
          pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                data['Applicant Name']
            ),
          ),
        ],
      ),
    );
  }

  // Input Widget
  Container inputWidget(String? title) {

    return Container(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
              color: Colors.indigoAccent
          ),
          hintText: title,
          hintStyle: const TextStyle(
              color: Colors.black54
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigoAccent)
          )
        ),
        validator: (value) {
          if(value.toString().isEmpty){
              return 'Text field is empty';
          }else{
            return null;
          }
        },
        onSaved: (value) {
          data['$title'] = value!;
        },
      )
    );
  }

  //Button Widget
  ElevatedButton _button(String title, var onclick) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.indigoAccent,
          onPrimary: Colors.white,
          minimumSize: Size(200, 50),
          elevation: 2,
          shadowColor: Colors.black87),
      child: Text(title),
      onPressed: onclick,
    );
  }

}
