import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  bool isLoading = false;
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    var url =
        'https://drive.google.com/uc?export=view&id=14ytDE_VBt2FlG1mEIyUiln_iTxnpLNJD';
    document = await PDFDocument.fromURL(url);
    setState(() {});
  }

  Future<void> loadNextPages() async {
    setState(() {
      isLoading = true;
    });
    // Загрузка следующих страниц
    await document?.preloadPages();
    setState(() {
      isLoading = false;
      currentPage += 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (document != null)
              NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                    loadNextPages();
                  }
                  return true;
                },
                child: Container(
                  height: 400,
                  width: 300,
                  child: PDFViewer(document: document!, lazyLoad: true),
                ),
              ),
            if (isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
