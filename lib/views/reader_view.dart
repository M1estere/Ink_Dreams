import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class ReaderView extends StatefulWidget {
  final String filePath;

  const ReaderView({super.key, required this.filePath});

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  int startPage = 0;

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
              Text(
                'Attack On Titan [1]'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       if (currentPageIndex > 1) {
        //         currentPageIndex--;
        //         controller!.ready?.goToPage(pageNumber: currentPageIndex);
        //       } else {
        //         controller!.ready?.goToPage(pageNumber: 1);
        //       }
        //       print(currentPageIndex);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //       size: 30,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       if (currentPageIndex < controller!.pageCount) {
        //         currentPageIndex++;
        //         controller!.ready?.goToPage(pageNumber: currentPageIndex);
        //       } else {
        //         controller!.ready?.goToPage(pageNumber: controller!.pageCount);
        //       }
        //       print(currentPageIndex);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_forward_ios,
        //       color: Colors.white,
        //       size: 30,
        //     ),
        //   ),
        //   const SizedBox(
        //     width: 10,
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.skip_next,
        //       color: Colors.white,
        //       size: 40,
        //     ),
        //   ),
        // ],
      ),
      body: Center(
        child: GestureDetector(
          child: PdfDocumentLoader.openAsset(
            widget.filePath,
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
