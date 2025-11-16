import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/consts/regular_expression.dart';
import 'package:nextalk/services/media_service.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';
import 'package:nextalk/widgets/rounded_image.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  PlatformFile? _profileImage;
  String? _email;
  String? _password;
  String? _name;
  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                GetIt.instance.get<MediaService>().pickImageFromLibrary().then((
                  file,
                ) {
                  setState(() {
                    _profileImage = file;
                  });
                });
              },
              child: RoundedImage(
                size: _deviceHeight * 0.15,
                file: _profileImage,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.05),
            SizedBox(
              height: _deviceHeight * 0.35,
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      onSaved: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      regEx: AppRegEx.emptyValidation,
                      hintText: 'Enter your Name',
                      validatorMessage: "Name Can't be empty",
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      regEx: AppRegEx.emailValidation,
                      hintText: 'Enter your email',
                      validatorMessage: 'Please enter a valid email',
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      regEx: AppRegEx.passwordValidation,
                      hintText: 'Enter your Password',
                      validatorMessage:
                          "Password Can't Be Less Than 8 Characters.",
                      obsecureText: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
