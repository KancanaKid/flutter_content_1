import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormLayout extends StatefulWidget {
  const FormLayout({super.key});

  @override
  State<FormLayout> createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool isPasswordVisible = false;
  List<String> cities = [
    "Jakarta",
    "Bandung",
    "Surabaya",
    "Yogyakarta",
    "Medan"
  ];
  String selectedOption = "";

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorMessage = 'Email is required';
      });
    } else if (!isEmaiValid(value)) {
      setState(() {
        _emailErrorMessage = 'Enter a valid email address';
      });
    } else {
      setState(() {
        _emailErrorMessage = null;
      });
    }
  }

  void _validatePassword(String value) {
    if (value.length < 8) {
      setState(() {
        _passwordErrorMessage = 'Password must be longer than 8 characters';
      });
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        _passwordErrorMessage = 'Uppercase character is missing';
      });
    } else if (!value.contains(RegExp(r'[a-z]'))) {
      setState(() {
        _passwordErrorMessage = 'Lowercase character is missing';
      });
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      setState(() {
        _passwordErrorMessage = 'Number character is missing';
      });
    } else if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      setState(() {
        _passwordErrorMessage = 'Special character is missing';
      });
    } else {
      setState(() {
        _passwordErrorMessage = null;
      });
    }
  }

  bool isEmaiValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Form Layout"),
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "Fullname",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0))),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      errorText: _emailErrorMessage,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0))),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: _validateEmail,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Password",
                      errorText: _passwordErrorMessage,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      )),
                  keyboardType: TextInputType.text,
                  obscureText: isPasswordVisible,
                  onChanged: _validatePassword,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: dobController,
                  decoration: InputDecoration(
                      labelText: "Date Of Birth",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () async {
                          DateTime? datePicker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2100));
                          if (datePicker != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(datePicker);
                            setState(() {
                              dobController.text = formattedDate;
                            });
                          }
                        },
                      )),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                      labelText: "Select City",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: cities.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            cityController.text = cities[index];
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(cities[index]),
                                          ),
                                        );
                                      }),
                                );
                              });
                        },
                      )),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "M",
                            groupValue: selectedOption,
                            onChanged: (value) {}),
                        const Text("Male")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "F",
                            groupValue: selectedOption,
                            onChanged: (value) {}),
                        const Text("Female")
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: const Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
