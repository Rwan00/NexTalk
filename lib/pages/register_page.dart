import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/consts/regular_expression.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/services/cloud_storage_service.dart';
import 'package:nextalk/services/database_service.dart';
import 'package:nextalk/services/media_service.dart';

import 'package:nextalk/widgets/custom_button.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';
import 'package:nextalk/widgets/rounded_image.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  PlatformFile? _profileImage;

  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorageService;
 
  String? _email;
  String? _password;
  String? _name;
  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorageService = GetIt.instance<CloudStorageService>();
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
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
                  GetIt.instance
                      .get<MediaService>()
                      .pickImageFromLibrary()
                      .then((file) {
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
              SizedBox(height: _deviceHeight * 0.05),
              CustomButton(
                name: "Register",
                height: _deviceHeight * 0.065,
                width: _deviceWidth * 0.65,
                onPressed: () async {
                  if (_registerFormKey.currentState!.validate() &&
                      _profileImage != null) {
                    _registerFormKey.currentState!.save();
                    String? uid = await _auth.registerWithEmailAndPassword(
                      _email!,
                      _password!,
                    );
                    String? imageUrl = await _cloudStorageService
                        .saveUserImageToStorage(uid!, _profileImage!);
                    await _db.createUser(uid, _email!, imageUrl!, _name!);
                    await _auth.logout();
                    await _auth.loginWithEmailAndPassword(_email!, _password!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
