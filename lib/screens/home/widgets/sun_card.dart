import 'package:flutter/material.dart';

class SunCardCarousel extends StatefulWidget {
  const SunCardCarousel({super.key});

  @override
  State<SunCardCarousel> createState() => _SunCardCarouselState();
}

class _SunCardCarouselState extends State<SunCardCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> facts = [
    'El Paso gets over 300 days of sunshine a year. ☀️',
    'Franklin Mountains State Park is the largest urban park in the U.S. 🏞️',
    'El Paso is one of the safest large cities in America. 🛡️',
    'You can see both Mexico and the U.S. from Scenic Drive. 🌄',
    'El Paso’s nickname is "The Sun City". 🌞',
    'The historic Plaza Theatre opened in 1930 and still operates today. 🎭',
  ];

  void _goToNextCard() {
    if (_currentPage < facts.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousCard() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: facts.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            physics: const NeverScrollableScrollPhysics(), // disable swipe
            itemBuilder: (context, index) {
              return _buildInteractiveCard(facts[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(facts.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.deepOrange
                    : Colors.deepOrange.withOpacity(0.3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildInteractiveCard(String fact) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  fact,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),

          //left tap
          Positioned.fill(
            left: 0,
            right: MediaQuery.of(context).size.width / 2,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _goToPreviousCard,
            ),
          ),

          // right tap
          Positioned.fill(
            left: MediaQuery.of(context).size.width / 2,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _goToNextCard,
            ),
          ),
        ],
      ),
    );
  }
}
