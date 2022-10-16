import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/controllers/controller.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/input_field.dart';
import '../widgets/social_button.dart';

class SignInPage extends NyStatefulWidget {
  final Controller controller = Controller();
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends NyState<SignInPage> {
  Map<String, dynamic> _signInData = {
    "email": "",
    "password": "",
    "rememberMe": false,
  };

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Welcome back. Sign in to continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        margin: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  InputField(
                    label: 'Email',
                    hint: 'johndoe@example.com',
                    onChanged: (value) {
                      _signInData['email'] = value;
                    },
                    textInputType: TextInputType.emailAddress,
                  ),
                  InputField(
                    label: 'Password',
                    hint: '*******',
                    onChanged: (value) {
                      _signInData['password'] = value;
                    },
                    textInputType: TextInputType.visiblePassword,
                    isSecret: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              side: BorderSide(
                                color: Color(0xFFC5CAD4),
                                width: 1,
                              ),
                              activeColor: ThemeColor.get(context).primary,
                              value: _signInData['rememberMe'],
                              onChanged: (value) {
                                setState(
                                  () {
                                    _signInData['rememberMe'] = value;
                                  },
                                );
                              },
                            ),
                          ),
                          Text(
                            'Remember me?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Divider()),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "or",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width,
                    margin: const EdgeInsets.only(bottom: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SocialButton(
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _handleSignIn();
                          },
                        ),
                        SocialButton(
                          icon: FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Color(0xFF1877F2),
                          ),
                          onPressed: () {},
                        ),
                        SocialButton(
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      Text(
                        'I don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ThemeColor.get(context).primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
