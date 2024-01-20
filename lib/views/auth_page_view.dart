import 'package:flutter/material.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/views/main_app_wrapper.dart';
import 'package:page_transition/page_transition.dart';

class AuthPageView extends StatefulWidget {
  const AuthPageView({super.key});

  @override
  State<AuthPageView> createState() => _AuthPageViewState();
}

class _AuthPageViewState extends State<AuthPageView> {
  TextEditingController registerNickname = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerConfirmPassword = TextEditingController();

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  PageController pageController = PageController();
  bool signInOpened = true;

  bool regPasswordVisible = false;
  bool logPasswordVisible = false;

  String regErrorText = '';
  bool hasRegError = false;

  String logErrorText = '';
  bool hasLogError = false;

  @override
  void dispose() {
    super.dispose();

    registerNickname.dispose();
    registerEmail.dispose();
    registerPassword.dispose();
    registerConfirmPassword.dispose();

    loginEmail.dispose();
    loginPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .23,
                width: MediaQuery.of(context).size.height * .23,
                child: const Image(
                  image: AssetImage(
                    'assets/images/icon-no-bg.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          signInOpened = true;
                          pageController.animateToPage(
                            0,
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color:
                                signInOpened ? Colors.red : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: signInOpened
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: signInOpened ? 22 : 20,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          signInOpened = false;
                          pageController.animateToPage(
                            1,
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color:
                                !signInOpened ? Colors.red : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: !signInOpened
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: signInOpened ? 22 : 20,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 420,
              child: PageView(
                onPageChanged: (value) {
                  if (mounted) {
                    setState(() {
                      signInOpened = value == 1 ? false : true;
                    });
                  }
                },
                controller: pageController,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).snackBarTheme.backgroundColor,
                            border: Border(
                              bottom: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              top: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              left: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              right: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: loginEmail,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  size: 25,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .prefixIconColor,
                                ),
                                hintText: 'Enter email...',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).snackBarTheme.backgroundColor,
                            border: Border(
                              bottom: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              top: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              left: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              right: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: loginPassword,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              obscureText: logPasswordVisible ? false : true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                prefixIcon: Icon(
                                  Icons.key,
                                  size: 25,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .prefixIconColor,
                                ),
                                hintText: 'Enter password...',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    logPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 27,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        logPasswordVisible =
                                            !logPasswordVisible;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          child: InkWell(
                            splashColor: Colors.red.withOpacity(.6),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              if (loginEmail.text.trim().isEmpty ||
                                  loginPassword.text.trim().isEmpty) {
                                if (mounted) {
                                  setState(() {
                                    hasLogError = true;
                                    logErrorText = 'Fill all fields';
                                  });
                                }
                                return;
                              }

                              signIn(
                                loginEmail.text.trim(),
                                loginPassword.text.trim(),
                              ).then(
                                (value) {
                                  if (mounted) {
                                    switch (value) {
                                      case 0: // all good
                                        Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: const MainWrapper(),
                                          ),
                                        );
                                        break;
                                      case 1:
                                        setState(() {
                                          hasLogError = true;
                                          logErrorText = 'User not found';
                                        });
                                        break;
                                      case 2:
                                        setState(() {
                                          hasLogError = true;
                                          logErrorText = 'Wrong password';
                                        });
                                        break;
                                      case 3:
                                        setState(() {
                                          hasLogError = true;
                                          logErrorText = 'Invalid email';
                                        });
                                        break;
                                      case 4:
                                        setState(() {
                                          hasLogError = true;
                                          logErrorText = 'Something went wrong';
                                        });
                                        break;
                                    }
                                  }
                                },
                              );
                            },
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Sign In'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        hasLogError
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    logErrorText,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red,
                                      fontSize: 18,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).snackBarTheme.backgroundColor,
                            border: Border(
                              bottom: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              top: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              left: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              right: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: registerNickname,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 25,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .prefixIconColor,
                                ),
                                hintText: 'Enter your nickname...',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).snackBarTheme.backgroundColor,
                            border: Border(
                              bottom: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              top: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              left: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              right: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: registerEmail,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  size: 25,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .prefixIconColor,
                                ),
                                hintText: 'Enter email...',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).snackBarTheme.backgroundColor,
                            border: Border(
                              bottom: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              top: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              left: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              right: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: registerPassword,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              obscureText: regPasswordVisible ? false : true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                prefixIcon: Icon(
                                  Icons.key,
                                  size: 25,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .prefixIconColor,
                                ),
                                hintText: 'Enter password...',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    regPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        regPasswordVisible =
                                            !regPasswordVisible;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).snackBarTheme.backgroundColor,
                            border: Border(
                              bottom: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              top: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              left: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                              right: Theme.of(context)
                                  .inputDecorationTheme
                                  .outlineBorder!,
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: registerConfirmPassword,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                prefixIcon: Icon(
                                  Icons.verified_rounded,
                                  size: 25,
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .prefixIconColor,
                                ),
                                hintText: 'Confirm password...',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          child: InkWell(
                            splashColor: Colors.red.withOpacity(.6),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              if (registerPassword.text.trim() !=
                                  registerConfirmPassword.text.trim()) {
                                if (mounted) {
                                  setState(() {
                                    hasRegError = true;
                                    regErrorText = 'Passwords mismatch';
                                  });
                                }
                                return;
                              }

                              if (registerEmail.text.trim().isEmpty ||
                                  registerPassword.text.trim().isEmpty ||
                                  registerConfirmPassword.text.trim().isEmpty ||
                                  registerNickname.text.trim().isEmpty) {
                                if (mounted) {
                                  setState(() {
                                    hasRegError = true;
                                    regErrorText = 'Fill all fields';
                                  });
                                }
                                return;
                              }

                              registerUser(
                                registerEmail.text.trim(),
                                registerPassword.text.trim(),
                                registerNickname.text.trim(),
                              ).then(
                                (value) {
                                  if (mounted) {
                                    switch (value) {
                                      case 0: // all good
                                        Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: const MainWrapper(),
                                          ),
                                        );
                                        break;
                                      case 1:
                                        setState(() {
                                          hasRegError = true;
                                          regErrorText = 'Weak password';
                                        });
                                        break;
                                      case 2:
                                        setState(() {
                                          hasRegError = true;
                                          regErrorText = 'Email is in use';
                                        });
                                        break;
                                      case 3:
                                        setState(() {
                                          hasRegError = true;
                                          regErrorText = 'Invalid email';
                                        });
                                        break;
                                      default:
                                        setState(() {
                                          hasRegError = true;
                                          regErrorText = 'Something went wrong';
                                        });
                                        break;
                                    }
                                  }
                                },
                              );
                            },
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Sign Up'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        hasRegError
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    regErrorText,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red,
                                      fontSize: 18,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
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
