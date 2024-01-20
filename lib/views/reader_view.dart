import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class ReaderView extends StatefulWidget {
  List<Map?>? chapters;
  int index;

  String filePath;
  String title;
  String defTitle;
  String confTitle;

  Function updateFunc;

  ReaderView({
    super.key,
    required this.chapters,
    required this.index,
    required this.filePath,
    required this.title,
    required this.defTitle,
    required this.confTitle,
    required this.updateFunc,
  });

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  bool hasNext = true;
  bool hasPrev = true;

  bool isLoading = true;

  double percentage = 0;

  @override
  void initState() {
    super.initState();

    addToReadingSection(
            widget.chapters![widget.index]!['name'], widget.defTitle)
        .then((value) {
      widget.updateFunc();
    });

    recheck();
  }

  void recheck() {
    if (mounted) {
      setState(() {
        hasNext = true;
        hasPrev = true;

        if (widget.index >= widget.chapters!.length - 1) {
          hasNext = false;
        }

        if (widget.index <= 0) {
          hasPrev = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: Container(
          width: double.infinity,
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
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .63,
                child: SizedBox(
                  child: Text(
                    widget.title.toUpperCase(),
                    style: TextStyle(
                      color:
                          Theme.of(context).appBarTheme.titleTextStyle!.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          hasPrev
              ? IconButton(
                  visualDensity: const VisualDensity(
                    horizontal: -4.0,
                    vertical: -4.0,
                  ),
                  iconSize: 25,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          widget.index -= 1;
                          widget.filePath =
                              widget.chapters![widget.index]!['link'];
                          widget.title =
                              "${widget.defTitle} - v${widget.chapters![widget.index]!['name']}";

                          return super.widget;
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                )
              : const SizedBox(
                  width: 25,
                ),
          hasNext
              ? IconButton(
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                  iconSize: 25,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          widget.index += 1;
                          widget.filePath =
                              widget.chapters![widget.index]!['link'];
                          widget.title =
                              "${widget.defTitle} - v${widget.chapters![widget.index]!['name']}";

                          return super.widget;
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                )
              : const SizedBox(
                  width: 40,
                ),
        ],
      ),
      body: Center(
          child: FutureBuilder<File>(
        future: DefaultCacheManager().getSingleFile(widget.filePath),
        builder: (context, snapshot) => snapshot.hasData
            ? PdfDocumentLoader.openFile(
                onError: (p0) {
                  return const Center(
                    child: Text(
                      'Some error occured',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                },
                snapshot.data!.path,
                documentBuilder: (context, pdfDocument, pageCount) =>
                    LayoutBuilder(
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
              )
            : const FetchingCircle(),
      )),
    );
  }
}
