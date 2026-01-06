import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/pages/profile/widgets/profile_text_field.dart';
import 'package:carsmeelien/pages/profile/widgets/info_tile.dart'; 
import 'package:carsmeelien/pages/damage_reports/damage_reports_page.dart';
import 'package:carsmeelien/pages/favorites_page.dart';
import 'package:carsmeelien/pages/rent_history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Hallo', style: AppAppBar.titleTextStyle1),
              TextSpan(text: ' Kars!', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userDataSection(),
            const SizedBox(height: 24),
            _informationSection(context),
          ],
        ),
      ),
    );
  }

  Widget _userDataSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gegevens', style: AppTextStyles.sectionHeader),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16), 
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: const [
                ProfileTextField(
                  hint: 'Naam',
                  icon: Icons.person_outline,
                ),
                SizedBox(height: 12),
                ProfileTextField(
                  hint: 'E-mailadres',
                  icon: Icons.email_outlined,
                ),
                SizedBox(height: 12),
                ProfileTextField(
                  hint: 'Wachtwoord',
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Informatie', style: AppTextStyles.sectionHeader),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                InfoTile(
                  icon: Icons.favorite_border,
                  title: 'Favorieten',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoritesPage(),
                      ),
                    );
                  },
                ),
                InfoTile(
                  icon: Icons.history,
                  title: 'Huurhistorie',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RentHistoryPage(),
                      ),
                    );
                  },
                ),
                InfoTile(
                  icon: Icons.report_problem_outlined,
                  title: 'Schademeldingen',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DamageReportsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}