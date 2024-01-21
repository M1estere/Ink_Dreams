import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/views/manga_page_view.dart';

class UserSectionBlock extends StatelessWidget {
  final String title;
  final String status;
  final int chapters;
  final String author;
  final String image;
  final String desc;
  final Timestamp addDate;
  final Function updateFunc;

  const UserSectionBlock({
    super.key,
    required this.title,
    required this.chapters,
    required this.status,
    required this.author,
    required this.image,
    required this.desc,
    required this.addDate,
    required this.updateFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          bottom: Theme.of(context).inputDecorationTheme.outlineBorder!,
          top: Theme.of(context).inputDecorationTheme.outlineBorder!,
          left: Theme.of(context).inputDecorationTheme.outlineBorder!,
          right: Theme.of(context).inputDecorationTheme.outlineBorder!,
        ),
      ),
      height: MediaQuery.of(context).size.height * .25,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MangaPageView(title: title),
              ),
            ).then((value) => updateFunc());
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 15,
              right: 3,
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
                    width: MediaQuery.of(context).size.width * .48,
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.red,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(addDate.toDate()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Row(
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
                              maxLines: 3,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
