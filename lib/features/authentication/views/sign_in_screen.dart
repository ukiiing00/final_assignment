import 'package:final_assignment/features/authentication/view_models/sign_in_view_model.dart';
import 'package:final_assignment/features/authentication/views/sign_up_screen.dart';
import 'package:final_assignment/features/authentication/widgets/sign_in_button.dart';
import 'package:final_assignment/features/constants/gaps.dart';
import 'package:final_assignment/features/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  static const String routeUrl = '/signin';
  static const String routeName = 'signin';

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailEditingController = TextEditingController();

  String _emailPhone = "";
  bool _obscureText = true;
  bool emailValid = false;
  bool passwordValid = false;

  final Map<String, String> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    _emailEditingController.addListener(() {
      _emailPhone = _emailEditingController.text;
      setState(() {});
    });
  }

  void _onSubmitTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(loginFormProvider.notifier).state = {
          "email": _formData["email"],
          "password": _formData["password"],
        };
        ref.read(signInProvider.notifier).signIn();
      }
    }
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _onClearTap() {
    _passwordFieldKey.currentState?.reset();
  }

  String? _isEmailPhoneNumberValid() {
    if (_emailPhone.isEmpty) return null;
    final reqExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!reqExp.hasMatch(_emailPhone)) {
      emailValid = false;
      return "올바른 이메일 주소를 입력해주세요.";
    } else {
      emailValid = true;
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length < 8) {
      passwordValid = false;
      return "비밀번호를 8자리 이상 입력해주세요.";
    }
    passwordValid = true;
    return null;
  }

  void _unFocusOf() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    context.goNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unFocusOf,
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          "MOODMODU",
                          style: TextStyle(
                            fontSize: Sizes.size30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 30,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailEditingController,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size14,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontSize: Sizes.size18,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "이메일주소를 입력해주세요";
                                }
                                return _isEmailPhoneNumberValid();
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  _formData['email'] = newValue;
                                }
                              },
                            ),
                            Gaps.v14,
                            TextFormField(
                              key: _passwordFieldKey,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size14,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontSize: Sizes.size18,
                                  color: Colors.grey.shade900,
                                ),
                                suffix: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: _onClearTap,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircleXmark,
                                        color: Colors.grey.shade500,
                                        size: Sizes.size20,
                                      ),
                                    ),
                                    Gaps.h10,
                                    GestureDetector(
                                      onTap: _toggleObscureText,
                                      child: FaIcon(
                                        _obscureText
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        color: Colors.grey.shade500,
                                        size: Sizes.size20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onChanged: (value) {
                                _passwordFieldKey.currentState?.validate();
                              },
                              validator: (value) {
                                if (value!.isEmpty) return null;
                                String? valid = _validatePassword(value);
                                return valid;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  _formData['password'] = newValue;
                                }
                              },
                            ),
                            Gaps.v48,
                            SignInButton(onSubmitTap: _onSubmitTap),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Sizes.size96,
              child: Center(
                child: GestureDetector(
                  onTap: _onNextTap,
                  child: const Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
