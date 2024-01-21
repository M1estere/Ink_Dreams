import 'package:flutter/material.dart';

class PersonalizePageView extends StatefulWidget {
  const PersonalizePageView({super.key});

  @override
  State<PersonalizePageView> createState() => _PersonalizePageViewState();
}

class _PersonalizePageViewState extends State<PersonalizePageView> {
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
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                'edit account'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 5,
                ),
                height: MediaQuery.of(context).size.height * .3,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.red,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          'profile'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .25,
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 45,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.yellow,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.camera,
                                      color: Colors.red,
                                      size: 45,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.save_as,
                                      color: Colors.red,
                                      size: 45,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            child: TextField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                              ),
                              decoration: InputDecoration(
                                helperText: 'Your nickname',
                                helperStyle: TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .5,
                                ),
                                prefixIcon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Color(0xFFA2A2A2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF252525),
                ),
                child: const SizedBox(
                  child: Center(
                    child: Text(
                      'LOG OUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
