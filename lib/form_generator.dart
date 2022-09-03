import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'input_field.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FormGenerator());
}

class FormGenerator extends StatefulWidget {
  @override
  State<FormGenerator> createState() => _FormGeneratorState();
}

class _FormGeneratorState extends State<FormGenerator> {

  // Menu List
  var list = ["Job Application Letter", "Category1", "Category2"];
  String? value = "Job Application Letter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text("Create PDF Application"),
      ),
      body: Container(
          margin: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 5, bottom: 5),
                  child: const Text(
                      "SELECT APPLICATION CATEGORY"
                          ,style: TextStyle(
                          fontWeight: FontWeight.w500,

                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: _menuButton(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                    left: 5,
                    bottom: 10,
                    top: 30,
                  ),
                  child: Text(
                      "Please fill your information to generate application "+value.toString()+
                    " format's pdf file",
                      style: const TextStyle(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                  ),
                ),
                InputField(value),
              ],
            ),
          )),
    );
  }

  // DropDownButton Widget
  DropdownButton<String> _menuButton() {
    return DropdownButton(
        items: list.map(buildMenuItem).toList(),
        value: value,
        style: const TextStyle(
            color: Colors.white,
        ),
        underline: Container(),
        iconEnabledColor: Colors.white,
        isExpanded: true,
        dropdownColor: Colors.indigoAccent,
        onChanged: (value) => setState(() => this.value = value)
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child:
          Text(
            item,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16
            ),
          ),
      ),
  );

}
