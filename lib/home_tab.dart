import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page.dart'; // Ensure this import is present to access HomePageState

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'robloxhackers.lol',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to robloxhackers.lol, your go-to source for the latest information on security vulnerabilities, exploits, and updates. Stay ahead of potential threats and keep your knowledge up-to-date with our comprehensive resources.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildCard(
                        context,
                        'Reddit',
                        'Join our Reddit community for the latest updates and discussions.',
                        Theme.of(context).colorScheme.primary,
                        Icons.reddit,
                        'Visit Reddit',
                        () {
                          _launchURL(context, 'https://reddit.com/r/robloxhackers');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildCard(
                        context,
                        'Discord',
                        'Join our Discord server to chat with other members in real-time.',
                        Theme.of(context).colorScheme.secondary,
                        Icons.discord,
                        'Visit Discord',
                        () {
                          _launchURL(context, 'https://discord.gg/robloxhackers');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildCard(
                context,
                'Stay Updated with Latest Exploits',
                'Keep yourself informed with the latest information on security vulnerabilities and exploits. Visit our Exploits Page for detailed updates and stay ahead of potential threats.',
                Theme.of(context).colorScheme.primary,
                Icons.security,
                'Go to Exploits Page',
                () {
                  const pageIndex = 1;
                  _navigateToPage(context, pageIndex);
                },
              ),
              const SizedBox(height: 10),
              _buildCard(
                context,
                'Important News and Announcements',
                'Visit the News Page to learn more about the latest news and announcements.',
                Theme.of(context).colorScheme.error,
                Icons.article,
                'Go to News Page',
                () {
                  const pageIndex = 2;
                  _navigateToPage(context, pageIndex);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description, Color color, IconData icon, String buttonText, VoidCallback onPressed) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  void _navigateToPage(BuildContext context, int pageIndex) {
    final homePageState = context.findAncestorStateOfType<HomePageState>();
    homePageState?.navigateToPage(pageIndex);
  }
}
