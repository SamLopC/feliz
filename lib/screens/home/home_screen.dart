import 'package:flutter/material.dart';
import 'package:feliz/screens/home/widgets/ask_button.dart';
import 'package:feliz/screens/home/widgets/greeting_header.dart';
import 'package:feliz/screens/home/widgets/sun_card.dart';
import 'package:feliz/services/user_profile_service.dart';
import 'package:feliz/services/local_insight_service.dart';
// import 'package:feliz/services/ai_query_service.dart';
class HomeMainScreen extends StatelessWidget {
  final Function(bool) onToggleTheme;
  final bool isDarkMode;

  const HomeMainScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // UserProfileService.loadUser();
    // LocalInsightService.loadCityInfo();

    return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: const Text(
              'Sun City AI',
              style: TextStyle(color: Colors.orange),
            ),
            centerTitle: true,
            actions: [
              Switch(
                value: isDarkMode,
                onChanged: onToggleTheme,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.black,
              ),
            ],
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GreetingHeader(),
            const SizedBox(height: 30),
            const SunCardCarousel(),
            const SizedBox(height: 30),
            AskButton(onPressed: () {
              // AIQueryService.startChat(context);
            }),
          ],
        ),
      ),
    );
  }
}
