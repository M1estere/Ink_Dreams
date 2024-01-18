import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/views/manga_page_view.dart';
import 'package:page_transition/page_transition.dart';

class RatedMangaBlock extends StatelessWidget {
  final String title;
  final String status;
  final int chapters;
  final String author;
  final String image;
  final String desc;
  final int userRate;
  final Timestamp finishDate;
  final Function? updateFunc;

  const RatedMangaBlock({
    super.key,
    required this.title,
    required this.chapters,
    required this.status,
    required this.author,
    required this.image,
    required this.desc,
    required this.userRate,
    required this.finishDate,
    this.updateFunc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: MangaPageView(title: title),
          ),
        ).then((value) {
          if (updateFunc != null) {
            updateFunc!();
          }
        });
      },
      child: Container(
        height: 215,
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 15,
            right: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: double.infinity,
                width: MediaQuery.of(context).size.width * .33,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    fit: BoxFit.cover,
                    image,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .485,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            author,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 82,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Icon(
                                        index < userRate
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.yellow,
                                        size: 15,
                                      );
                                    },
                                  ),
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 5,
                                  color: Colors.red,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .24,
                                  padding: const EdgeInsets.only(left: 7),
                                  child: FittedBox(
                                    child: Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(finishDate.toDate()),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.book,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                  Text(
                                    chapters.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                  Text(
                                    status.capitalize(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            desc,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 4,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Status: ',
                      //     style: const TextStyle(
                      //       fontSize: 15,
                      //       letterSpacing: 1,
                      //       fontWeight: FontWeight.w500,
                      //       color: Colors.grey,
                      //     ),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text: status,
                      //         style: const TextStyle(
                      //           color: Colors.red,
                      //           letterSpacing: 1,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
