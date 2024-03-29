import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/support/app_theme.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/user_full.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/auth_page_view.dart';
import 'package:manga_reading/views/crop_page_view.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  final TextEditingController _nicknameController = TextEditingController();
  UserFull _pageUser = UserFull(
    id: '',
    email: '',
    nickname: '',
    registerDate: Timestamp.fromDate(DateTime.now()),
    friends: 0,
    imagePath: '',
  );

  bool _mainLoading = true;
  bool _isLoading = false;

  Future<bool> _pickImageFromGallery() async {
    _isLoading = true;

    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => CropPageView(
                imageFile: File(returnedImage.path),
              ),
            ),
          )
          .then((value) => _isLoading = false);
    } else {
      return false;
    }

    return true;
  }

  openCropPage(XFile file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CropPageView(
          imageFile: File(file.path),
        ),
      ),
    );
  }

  Future<void> _showPictureDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
          surfaceTintColor: Theme.of(context).snackBarTheme.backgroundColor,
          title: Text(
            'Change profile picture',
            style: TextStyle(
              color: Theme.of(context).snackBarTheme.contentTextStyle!.color,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          content: GestureDetector(
            onTap: () {
              if (!_isLoading) {
                _pickImageFromGallery();
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: Colors.grey,
                    size: 50,
                  ),
                  Text(
                    'Picture',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * .75,
              child: ClipRect(
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    splashColor: const Color.fromARGB(255, 34, 34, 34),
                    onTap: () {
                      if (!_isLoading) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                          ),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _hasError = false;
  Future<void> _showNicknameDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            surfaceTintColor: Theme.of(context).snackBarTheme.backgroundColor,
            title: Text(
              'Change your nickname',
              style: TextStyle(
                color: Theme.of(context).snackBarTheme.contentTextStyle!.color,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            content: GestureDetector(
              onTap: () {
                if (!_isLoading) {}
              },
              child: SizedBox(
                height: 85,
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .5,
                      ),
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        helperText: 'Nickname',
                        helperStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 25,
                          color: Colors.grey,
                        ),
                        suffixIcon: _hasError
                            ? const Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 25,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * .25,
                child: ClipRect(
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      splashColor: const Color.fromARGB(255, 34, 34, 34),
                      onTap: () {
                        if (!_isLoading) {
                          if (_nicknameController.text.trim().isEmpty ||
                              _nicknameController.text.trim().length < 2) {
                            if (mounted) {
                              setState(() {
                                _hasError = true;
                              });
                            }
                          } else {
                            updateNickname(_nicknameController.text.trim());
                            Navigator.of(context).pop();

                            if (mounted) {
                              setState(() {
                                _hasError = false;
                              });
                            }
                          }
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'save'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.5,
                            ),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * .25,
                child: ClipRect(
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      splashColor: const Color.fromARGB(255, 34, 34, 34),
                      onTap: () {
                        if (!_isLoading) {
                          Navigator.of(context).pop();
                          if (mounted) {
                            setState(() {
                              _hasError = false;
                              _nicknameController.text = _pageUser.nickname;
                            });
                          }
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'cancel'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.5,
                            ),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _currentTheme =
      AppTheme().themeMode.toString().replaceFirst('ThemeMode.', '');
  Future<void> _showThemePopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
          surfaceTintColor: Theme.of(context).snackBarTheme.backgroundColor,
          title: Text(
            'Change app theme',
            style: TextStyle(
              color: Theme.of(context).snackBarTheme.contentTextStyle!.color,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          content: GestureDetector(
            onTap: () {
              if (!_isLoading) {}
            },
            child: SizedBox(
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    selectedColor: Colors.red,
                    title: Text(
                      'Light',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio(
                      value: 'light',
                      groupValue: _currentTheme,
                      onChanged: (value) {
                        Navigator.of(context).pop();
                        if (mounted) {
                          setState(() {
                            _currentTheme = value;
                            AppTheme().enableTheme(_currentTheme!, context);
                          });
                        }
                      },
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    selectedColor: Colors.red,
                    title: Text(
                      'Dark',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio(
                      value: 'dark',
                      groupValue: _currentTheme,
                      onChanged: (value) {
                        Navigator.of(context).pop();
                        if (mounted) {
                          setState(() {
                            _currentTheme = value;
                            AppTheme().enableTheme(_currentTheme!, context);
                          });
                        }
                      },
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    selectedColor: Colors.red,
                    title: Text(
                      'System',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio(
                      value: 'system',
                      groupValue: _currentTheme,
                      onChanged: (value) {
                        setState(() {
                          Navigator.of(context).pop();
                          if (mounted) {
                            setState(() {
                              _currentTheme = value;
                              AppTheme().enableTheme(_currentTheme!, context);
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    getFullUserInfo(currentUser!.id).then((value) {
      if (mounted) {
        setState(() {
          _pageUser = value;
          _nicknameController.text = _pageUser.nickname;
          _mainLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .6,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'settings'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * .95,
        child: SingleChildScrollView(
          child: !_mainLoading
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .22,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'profile'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey.withOpacity(.3),
                                onTap: () {
                                  signOut().then((value) {
                                    if (value == 0) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) {
                                            return const AuthPageView();
                                          }),
                                        ),
                                      );
                                    } else {
                                      print('No user');
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 45,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Log Out',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey.withOpacity(.3),
                                onTap: () {
                                  _showPictureDialog();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 45,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Change profile picture',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey.withOpacity(.3),
                                onTap: () {
                                  _showNicknameDialog();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 62,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Change nickname',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        _pageUser.nickname,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Divider(
                        color: Colors.grey,
                        height: 1,
                        thickness: 1.2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'app'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey.withOpacity(.3),
                                onTap: () {
                                  _showThemePopup();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 65,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Change app theme',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        _currentTheme!.capitalize(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const FetchingCircle(),
        ),
      ),
    );
  }
}
