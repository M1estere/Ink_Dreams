import 'dart:ui';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/views/category_page_view.dart';
import 'package:flip_card/flip_card.dart';

class CategoryBlock extends StatefulWidget {
  final String image;
  final String title;
  final String desc;

  const CategoryBlock({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  State<CategoryBlock> createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  final _controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryPageView(categoryTitle: widget.title),
            ),
          );
        },
        child: FlipCard(
          controller: _controller,
          flipOnTouch: false,
          direction: FlipDirection.HORIZONTAL,
          side: CardSide.FRONT,
          back: Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: Stack(children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Transform.scale(
                    scaleX: -1,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 2.5,
                        sigmaY: 2.5,
                      ),
                      child: Image.network(
                        fit: BoxFit.cover,
                        widget.image,
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
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.7),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title.capitalize(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            IconButton(
                              onPressed: () {
                                _controller.toggleCard();
                              },
                              icon: const Icon(
                                Icons.description,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          '\t\t${widget.desc}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
          front: Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: Stack(children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    fit: BoxFit.cover,
                    widget.image,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () {
                        _controller.toggleCard();
                      },
                      icon: const Icon(
                        Icons.description,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.75),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.title.capitalize(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
