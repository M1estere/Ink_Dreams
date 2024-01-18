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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      setState(() {
                        signInOpened = true;
                        pageController.animateToPage(
                          0,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
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
                              ? Colors.white
                              : const Color(0xFF6D6D6D),
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
                      setState(() {
                        signInOpened = false;
                        pageController.animateToPage(
                          1,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      });
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
                              ? Colors.white
                              : const Color(0xFF6D6D6D),
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
                  setState(() {
                    signInOpened = value == 1 ? false : true;
                  });
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
                            color: const Color(0xFF252525),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: loginEmail,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter email...',
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  size: 30,
                                  color: Color(0xFFA2A2A2),
                                ),
                                hintStyle: TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
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
                            color: const Color(0xFF252525),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: loginPassword,
                              obscureText: !logPasswordVisible,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter password...',
                                prefixIcon: const Icon(
                                  Icons.key,
                                  size: 30,
                                  color: Color(0xFFA2A2A2),
                                ),
                                hintStyle: const TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    logPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      logPasswordVisible = !logPasswordVisible;
                                    });
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
                          color: const Color(0xFF8E1617),
                          child: InkWell(
                            splashColor:
                                const Color(0xFF8E1617).withOpacity(.6),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              if (loginEmail.text.trim().isEmpty ||
                                  loginPassword.text.trim().isEmpty) {
                                setState(() {
                                  hasLogError = true;
                                  logErrorText = 'Fill all fields';
                                });
                                return;
                              }

                              signIn(
                                loginEmail.text.trim(),
                                loginPassword.text.trim(),
                              ).then(
                                (value) {
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
                            color: const Color(0xFF252525),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: registerNickname,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter your nickname...',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color(0xFFA2A2A2),
                                ),
                                hintStyle: TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
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
                            color: const Color(0xFF252525),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: registerEmail,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter email...',
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  size: 30,
                                  color: Color(0xFFA2A2A2),
                                ),
                                hintStyle: TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
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
                            color: const Color(0xFF252525),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              obscureText: !regPasswordVisible,
                              controller: registerPassword,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    regPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      regPasswordVisible = !regPasswordVisible;
                                    });
                                  },
                                ),
                                hintText: 'Enter password...',
                                prefixIcon: const Icon(
                                  Icons.key,
                                  size: 30,
                                  color: Color(0xFFA2A2A2),
                                ),
                                hintStyle: const TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
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
                            color: const Color(0xFF252525),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              obscureText: true,
                              controller: registerConfirmPassword,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                decorationStyle: TextDecorationStyle.dotted,
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Confirm your password...',
                                prefixIcon: Icon(
                                  Icons.verified_rounded,
                                  size: 30,
                                  color: Color(0xFFA2A2A2),
                                ),
                                hintStyle: TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
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
                          color: const Color(0xFF8E1617),
                          child: InkWell(
                            splashColor:
                                const Color(0xFF8E1617).withOpacity(.6),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              if (registerPassword.text.trim() !=
                                  registerConfirmPassword.text.trim()) {
                                setState(() {
                                  hasRegError = true;
                                  regErrorText = 'Passwords mismatch';
                                });
                                return;
                              }

                              if (registerEmail.text.trim().isEmpty ||
                                  registerPassword.text.trim().isEmpty ||
                                  registerConfirmPassword.text.trim().isEmpty ||
                                  registerNickname.text.trim().isEmpty) {
                                setState(() {
                                  hasRegError = true;
                                  regErrorText = 'Fill all fields';
                                });
                                return;
                              }

                              registerUser(
                                registerEmail.text.trim(),
                                registerPassword.text.trim(),
                                registerNickname.text.trim(),
                              ).then(
                                (value) {
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
