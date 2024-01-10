import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/firebase_options.dart';
import 'package:manga_reading/views/main_app_wrapper.dart';
import 'package:manga_reading/views/reader_view.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('categories_titles');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.onChildAdded.listen(
      (value) {
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          child: PdfDocumentLoader.openAsset(
            'assets/test.pdf',
            documentBuilder: (context, pdfDocument, pageCount) => LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pageCount,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  color: Colors.black12,
                  child: PdfPageView(
                    pdfDocument: pdfDocument,
                    pageNumber: index + 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9D1515),
        ),
        scaffoldBackgroundColor: const Color(0xFF23202B),
        useMaterial3: true,
      ),
      home: MainWrapper(),
    );
  }
}
