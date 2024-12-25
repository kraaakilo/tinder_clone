import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/models/user.dart';
import 'package:tinder_clone/providers/tinder_card_provider.dart';
import 'package:preload_page_view/preload_page_view.dart';

class TinderCard extends StatefulWidget {
  final bool isFront;
  final UserModel user;

  const TinderCard({super.key, required this.isFront, required this.user});

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  final PreloadPageController _pageController = PreloadPageController(
    initialPage: 0,
  );

  int activeIndex = 0;
  bool isPassionExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TinderCardProvider>(context, listen: false)
          .updateScreenSize(MediaQuery.of(context).size);
    });
    _pageController.addListener(() {
      setState(() {
        activeIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFront ? _buildInteractiveCard() : _buildCard();
  }

  Widget _buildCard() {
    debugPrint(widget.user.avatar);
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            PreloadPageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [1, 2, 3]
                  .map(
                    (image) => Image.network(
                      "http://192.168.1.30:8000/photos/LBCKBvkYGzIRroyRwvSoXgVyGg5drpH0DqX9i5VO.png",
                      fit: BoxFit.cover,
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        return loadingProgress == null
                            ? child
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  )
                  .toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.user.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: " ${widget.user.age}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.user.country,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedOpacity(
                            opacity: isPassionExpanded ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.user.passions
                                  .map(
                                    (interest) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Text(
                                        interest,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPassionExpanded = !isPassionExpanded;
                              });
                            },
                            child: const SizedBox(
                              width: 20,
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<TinderCardProvider>(context,
                                      listen: false)
                                  .like(isCliked: true);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1,
                                ),
                              ),
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Provider.of<TinderCardProvider>(context,
                                      listen: false)
                                  .dislike(isCliked: true);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                                weight: 1,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ].reversed.toList(),
            ),
            Positioned(
              top: 4,
              left: 16,
              right: 16,
              child: Wrap(
                spacing: 2,
                alignment: WrapAlignment.spaceEvenly,
                children: List.generate(
                  widget.user.photos.length,
                  (index) => Container(
                    color: index == activeIndex
                        ? Colors.white
                        : Colors.grey.withOpacity(0.5),
                    height: 2,
                    width: (MediaQuery.of(context).size.width /
                            widget.user.photos.length) -
                        20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveCard() {
    return GestureDetector(
      child: LayoutBuilder(
        builder: (context, constraints) {
          var provider = Provider.of<TinderCardProvider>(context);
          final int milliseconds = provider.isSwiping ? 0 : 400;

          final center = constraints.smallest.center(Offset.zero);
          final double rotation = provider.rotation * pi / 180;
          final rotationMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(rotation)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            transform: rotationMatrix
              ..translate(
                provider.position.dx,
                provider.position.dy,
              ),
            duration: Duration(milliseconds: milliseconds),
            child: _buildCard(),
          );
        },
      ),
      onPanUpdate: (details) {
        Provider.of<TinderCardProvider>(context, listen: false)
            .updatePosition(details);
      },
      onPanStart: (details) {
        Provider.of<TinderCardProvider>(context, listen: false)
            .startPosition(details);
      },
      onPanEnd: (details) {
        Provider.of<TinderCardProvider>(context, listen: false).endPosition();
      },
    );
  }
}
