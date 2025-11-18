import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/consts/regular_expression.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/routes/pages_routes.dart';
import 'package:nextalk/services/navigation_service.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/custom_button.dart';
import 'package:nextalk/widgets/custom_snackbar.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();

  late AuthenticationProvider _auth;
  late NavigationService _navigation;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    final auth = context.watch<AuthenticationProvider>();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (auth.loginStatus == AuthStatus.success) {
      CustomSnackBar.show(context, message: "Login Successful");
      auth.loginStatus = AuthStatus.init; // reset
    } else if (auth.loginStatus == AuthStatus.error) {
      CustomSnackBar.show(
        context,
        message: auth.errorMessage ?? "Something went wrong",
        isError: true,
      );
      auth.loginStatus = AuthStatus.init; // reset
    }
  });

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
            SizedBox(height: _deviceHeight * 0.04),
            CustomButton(
              name: "Login",
              height: _deviceHeight * 0.065,
              width: _deviceWidth * 0.65,
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  _loginFormKey.currentState!.save();
                  _auth.loginWithEmailAndPassword(_email!, _password!);
                }
              },
              isLoading: auth.loginStatus == AuthStatus.loading,
            ),
            SizedBox(height: _deviceHeight * 0.02),
            GestureDetector(
              onTap: () => _navigation.naviateToRoute(PagesRoutes.kRegisterPage),
              child: Text(
                "Don't Have An Account?",
                style: TextStyle(color: AppColors.kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
