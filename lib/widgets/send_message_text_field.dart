import 'package:flutter/material.dart';
import 'package:nextalk/providers/chat_provider.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';

class SendMessageTextField extends StatelessWidget {
  const SendMessageTextField({
    super.key,
    required double deviceHeight,
    required String token,
    required GlobalKey<FormState> messageFormState,
    required double deviceWidth,
    required ChatProvider chatProvider,
    required this.title,
  }) : _deviceHeight = deviceHeight,
       _messageFormState = messageFormState,
       _deviceWidth = deviceWidth,
       _chatProvider = chatProvider,
       _token = token;

  final double _deviceHeight;
  final GlobalKey<FormState> _messageFormState;
  final double _deviceWidth;
  final ChatProvider _chatProvider;
  final String _token;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _deviceHeight * 0.06,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(
        // horizontal: _deviceWidth * 0.04,
        vertical: _deviceHeight * 0.03,
      ),
      child: Form(
        key: _messageFormState,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: _deviceWidth * 0.7,
              child: CustomTextFormField(
                onSaved: (value) {
                  _chatProvider.message = value;
                },
                regEx: r"^(?!\s*$).+",
                hintText: "Type a message.",
              ),
            ),
            SizedBox(
              height: _deviceHeight * 0.04,
              width: _deviceHeight * 0.04,
              child: IconButton(
                onPressed: () {
                  if (_messageFormState.currentState!.validate()) {
                    _messageFormState.currentState!.save();
                    _chatProvider.sendTextMessage(_token,title);
                    _messageFormState.currentState!.reset();
                  }
                },
                icon: Icon(Icons.send),
              ),
            ),
            SizedBox(
              height: _deviceHeight * 0.04,
              width: _deviceHeight * 0.04,
              child: IconButton(
                onPressed: () {
                  _chatProvider.sendImageMessage(_token,title);
                },
                icon: Icon(Icons.camera_alt_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
