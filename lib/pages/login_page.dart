import 'package:flutter/material.dart';
import 'package:nextalk/consts/regular_expression.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/custom_button.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("NexTalk", style: AppTextStyles.headingStyle),
            SizedBox(height: _deviceHeight * 0.04),
            SizedBox(
              height: _deviceHeight * 0.18,
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      onSaved: (value) {},
                      regEx: AppRegEx.emailValidation,
                      hintText: 'Enter your email',
                      validatorMessage: 'Please enter a valid email',
                    ),
                    CustomTextFormField(
                      onSaved: (value) {},
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
            SizedBox(height: _deviceHeight * 0.04),
            CustomButton(
              name: "Login",
              height: _deviceHeight * 0.065,
              width: _deviceWidth * 0.65,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
