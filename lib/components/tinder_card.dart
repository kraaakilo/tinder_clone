import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/card_model.dart';
import 'package:tinder_clone/tinder_card_provider.dart';
import 'package:get/get.dart';

class TinderCard extends StatefulWidget {
  final bool isFront;
  final CardModel cardModel;

  const TinderCard({super.key, required this.isFront, required this.cardModel});

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int activeIndex = 0;

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
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.cardModel.photos
                  .map(
                    (image) => Image.network(
                      image,
                      fit: BoxFit.cover,
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
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Cardi B ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: "27",
                              style: TextStyle(
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
                            "${widget.cardModel.distance.toString()} km away",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.cardModel.interests
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
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.snackbar("title", "message");
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
                  widget.cardModel.photos.length,
                  (index) => Container(
                    color: index == activeIndex
                        ? Colors.white
                        : Colors.grey.withOpacity(0.5),
                    height: 2,
                    width: (MediaQuery.of(context).size.width /
                            widget.cardModel.photos.length) -
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
