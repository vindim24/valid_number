import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ValidNumber extends StatefulWidget {
  const ValidNumber({Key? key}) : super(key: key);

  @override
  _ValidNumberPage createState() => _ValidNumberPage();
}

class _ValidNumberPage extends State<ValidNumber>{

  final maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  bool _isTextFieldNotEmpty = false;

  late TextEditingController _phoneController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _phoneController = TextEditingController();
    _phoneController.addListener(() {
      final _isTextFieldNotEmpty = _phoneController.text.isNotEmpty;
      setState(() => this._isTextFieldNotEmpty = _isTextFieldNotEmpty);
    });
  }

  @override
  void dispose(){
    _phoneController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  )
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: "(201) 555-0123",
                    helperText: "Enter your phone number",
                    suffixIcon: _isTextFieldNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _phoneController.clear();
                          print("The button is working.");
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFFC0C0C0),
                        ),
                      )
                    : null
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [maskFormatter]
              ),
              const SizedBox(height: 25),
              const Text(
                "The answer will be typed into the log.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFC0C0C0),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _phoneController.text.length != 14
            ? null
            :(){
              setState(() {
                print(maskFormatter.getMaskedText());
          });
        },
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        )
      ),
    );
  }



}
