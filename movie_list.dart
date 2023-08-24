import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/item_model_v2.dart';

class movieListSlider extends StatefulWidget {
  final List<Item> item;

  const movieListSlider({super.key, required this.item});

  @override
  State<movieListSlider> createState() => _movieListSliderState();
}

//  late  ListItem   focusedbox; // Tanımını yukarı taşıdık.
class _movieListSliderState extends State<movieListSlider> {
  ScrollController _scrollController = ScrollController();

  late int _scrollindex = 0;
  late int _scrollindex_m = 0;

  // double sideLength = 130.0;
  double defheigh = 200.0;
  double defwidth = 150.0;


  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    RawKeyboard.instance.removeListener(_handleKeyEvent);
    super.dispose();
  }

  Future<void> _handleKeyEvent(RawKeyEvent event) async {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select) {}
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {}
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {}
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Item> movieItems =
        widget.item.where((item) => item.type == "Movies").toList();
    List<ListItem> liste = movieItems[0].listItems;
    late ItemElement focusedbox;
    focusedbox = liste[_scrollindex].items[_scrollindex_m];
    late ItemElement detay;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250.0,
            child: Column(
              children: [
                Center(
                    child: Text(
                  focusedbox.title,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),),
               // Text(_scrollindex.toString()),
                //Text(_scrollindex_m.toString())
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              scrollDirection: Axis.vertical,
              itemCount: liste.length,
              itemBuilder: (BuildContext context, int index) {
                List<ItemElement> movies = liste[index].items;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        child: Text(liste[index].grup +
                            ' - ' +
                            movies.length.toString()),
                      ),
                    ),
                    Container(
                      height: defheigh,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context_m, int index_m) {
                          detay = movies[index_m];
                          return Focus(
                            onFocusChange: (bool focusgained) {
                              if (focusgained) {
                                setState(() {
                                  focusedbox = liste[index].items[index_m];
                                  _scrollindex = index;
                                  _scrollindex_m = index_m;
                                  ;
                                }); // Scroll to the focused button

                                // Scroll to the focused button
                                double targetOffset = _scrollController.offset;
                                if (index > 0) {
                                  targetOffset = index *
                                      266; // Adjust this value based on your layout
                                } else {
                                  targetOffset = 0;
                                }
                                _scrollController.animateTo(
                                  targetOffset,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.fastOutSlowIn,
                                );
                              }
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              color: (_scrollindex_m == index_m &&
                                      _scrollindex == index)
                                  ? Colors.lime
                                  : Colors.transparent,
                              child: InkWell(
                                highlightColor: Colors.orange,
                                hoverColor: Colors.orange,
                                splashColor:
                                    Theme.of(context).primaryColorLight,
                                //     dragStartBehavior: DragStartBehavior.start,

                                onTap: () {},

                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: defheigh - 10,
                                        width: defwidth - 20,
                                        child: Column(children: [
                                          //  Text(liste.otitle),
                                          Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "https://m.media-amazon.com/images/" +
                                                        detay.cover,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                  child:

                                                      Container(
                                                    height: defheigh - 20,
                                                    width: defwidth - 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),

                                                    child: Text(
                                                      detay.title!,
                                                      style: TextStyle(
                                                        backgroundColor: Colors
                                                            .grey
                                                            .withOpacity(0.5),
                                                        color: Colors.black,
                                                        fontSize: 11.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),

                                              Positioned(
                                                right: 5,
                                                bottom: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                  ),

                                                  //    width: 60,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0),
                                                  // color: Colors.black.withOpacity((scrollOfset / 350).clamp(0, 1).toDouble()),

                                                  child: Text(
                                                    detay.rating,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              /*   */
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                    //   original_name(liste.hdr),
/*

*/
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
 
 
}
