import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Accessing inputs from textfields
  final TextEditingController noh = TextEditingController();
  final TextEditingController hr = TextEditingController();
  //Defining variables
  double rpay = 0;
  double otpay = 0;
  double ot = 40;
  double otr = 1.5;
  double tpay = 0;
  double tax = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            //TextField for hours
            TextField(
              //Controller
              controller: noh,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Number of Hours'),
              //KeyboardType
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              //Allowing Decimals
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final text = newValue.text;
                  return text.isEmpty
                      ? newValue
                      : double.tryParse(text) == null
                          ? oldValue
                          : newValue;
                }),
              ],
            ),
            const SizedBox(height: 30),
            //Textfield for hours worked
            TextField(
              //Controller
              controller: hr,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Hourly Rate'),
              //Keyboard Type
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              //Allowing Decimals
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final text = newValue.text;
                  return text.isEmpty
                      ? newValue
                      : double.tryParse(text) == null
                          ? oldValue
                          : newValue;
                }),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (noh.text.isEmpty || hr.text.isEmpty) {
                  // Show a dialog or handle the case where fields are empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill in all fields.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  double a = double.parse(noh.text);
                  double b = double.parse(hr.text);
                  setState(() {
                    if (a > ot) {
                      rpay = double.parse((ot * b).toStringAsFixed(2));
                      otpay = double.parse(
                          ((a - ot) * (b * otr)).toStringAsFixed(2));
                      tpay = double.parse(
                          ((ot * b) + (a - ot) * (b * otr)).toStringAsFixed(2));
                    } else {
                      otpay = 0;
                      rpay = double.parse((a * b).toStringAsFixed(2));
                      tpay = double.parse((a * b).toStringAsFixed(2));
                    }
                    tax = double.parse((tpay * 0.18).toStringAsFixed(2));
                  });
                }
              },
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 30),
            const Text(
              "Report",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Regular Pay: $rpay",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              "Overtime Pay: $otpay",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              "Total Pay: $tpay",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              "Tax: $tax",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 80),
            //Different Container for my info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black, // Set the background color for the box
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    "Name: Nibha Maharjan",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white, // Set the text color for the box
                    ),
                  ),
                  Text(
                    "Student ID: 301282952",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white, // Set the text color for the box
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
