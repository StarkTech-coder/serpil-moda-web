import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Required for Instagram icon
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme.dart';
import '../provider/service_provider.dart';
import '../widgets/faq_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/google_map_section.dart';
import '../widgets/process_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey _koleksiyonKey = GlobalKey();
  final GlobalKey _hizmetlerKey = GlobalKey();

  // Handles smooth scrolling to specific sections using GlobalKeys
  void _scrollToSection(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    });
  }

  // Opens WhatsApp with a pre-filled template message
  void _launchWhatsApp() async {
    const phone = "905439255608";
    const message =
        "Hello, I am contacting you from the Serpil Moda Evi website. I would like to get information and book an appointment.";
    final url =
        Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  // Redirects the user to the official Instagram profile
  void _launchInstagram() async {
    final url = Uri.parse("https://www.instagram.com/serpilmodaevi_bursa");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesStreamProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _launchWhatsApp,
        backgroundColor: const Color(0xFF25D366),
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text("Info & Appointment",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ).animate().scale(delay: 2.seconds),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        elevation: 0,
        title: const Text(
          'SERPIL MODA EVI',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              color: AppTheme.gold),
        ).animate().fadeIn(duration: 800.ms),
        actions: [
          _navButton("COLLECTION", () => _scrollToSection(_koleksiyonKey)),
          _navButton("SERVICES", () => _scrollToSection(_hizmetlerKey)),
          _navButton("CONTACT", _launchWhatsApp),
          // Instagram Social Icon
          IconButton(
            icon: const Icon(FontAwesomeIcons.instagram,
                color: AppTheme.gold, size: 20),
            onPressed: _launchInstagram,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildAboutSection(context),

            // 1. COLLECTION SECTION
            GallerySection(key: _koleksiyonKey),

            const SizedBox(height: 80),

            // 2. PROCESS SECTION (HOW WE WORK)
            const ProcessSection(),

            const SizedBox(height: 100),

            // 3. SERVICES SECTION
            _buildServicesHeader(context),
            _buildServicesSection(context, servicesAsync),

            const SizedBox(height: 80),

            // 4. FAQ SECTION (FREQUENTLY ASKED QUESTIONS)
            const FAQSection(),

            const SizedBox(height: 100),

            // 5. MAP AND CONTACT DETAILS
            const GoogleMapSection(),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  // --- Widget Methods (Hero, About, Services etc.) ---

  Widget _navButton(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(title,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, AppTheme.background],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tailored Elegance\nin Master Hands",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 48, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.gold),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 25)),
            onPressed: () => _scrollToSection(_koleksiyonKey),
            child: const Text("DISCOVER COLLECTION",
                style: TextStyle(color: AppTheme.gold)),
          ).animate(delay: 1.seconds).fadeIn(),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
      color: Colors.black.withValues(alpha: 0.2),
      child: Column(
        children: [
          const Text("THE ART OF TAILORING",
              style: TextStyle(
                  color: AppTheme.gold, fontSize: 13, letterSpacing: 6)),
          const SizedBox(height: 25),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Text(
              "As Serpil Moda Evi, we have been stitching your stories for over 20 years with master hands that breathe soul into the fabric. We work meticulously at every stitch to create unique masterpieces that reflect your self-confidence and elegance.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 2,
                  fontSize: 19,
                  fontStyle: FontStyle.italic),
            ),
          ).animate().fadeIn(duration: 1.seconds),
          const SizedBox(height: 30),
          const SizedBox(
              width: 40, child: Divider(color: AppTheme.gold, thickness: 1.5)),
        ],
      ),
    );
  }

  Widget _buildServicesHeader(BuildContext context) {
    return Column(
      key: _hizmetlerKey,
      children: [
        const Text("MEN & WOMEN TAILORING ART",
            style: TextStyle(
                color: AppTheme.gold, fontSize: 13, letterSpacing: 5)),
        const SizedBox(height: 15),
        Text("Bespoke Cutting, Perfect Form",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 28, fontWeight: FontWeight.w300)),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "In our atelier, we combine classical tailoring discipline with modern designs in both men's and women's clothing.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 16),
          ),
        ),
        const SizedBox(height: 40),
      ],
    ).animate().fadeIn();
  }

  Widget _buildServicesSection(BuildContext context, AsyncValue servicesAsync) {
    return servicesAsync.when(
      data: (services) {
        if (services.isEmpty) {
          return const Center(
            child: Text("Loading services...",
                style: TextStyle(color: Colors.white54)),
          );
        }

        final double width = MediaQuery.of(context).size.width;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: width > 1200 ? 100 : 40),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width > 900 ? 2 : 1,
            childAspectRatio: width > 1400 ? 2.5 : (width > 900 ? 2.0 : 1.8),
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];

            IconData serviceIcon = Icons.design_services_outlined;
            String titleLower = service.title.toLowerCase();

            // Assign icons based on service categories
            if (titleLower.contains("takım") || titleLower.contains("suit")) {
              serviceIcon = Icons.straighten;
            } else if (titleLower.contains("abiye") ||
                titleLower.contains("dress")) {
              serviceIcon = Icons.auto_awesome;
            } else if (titleLower.contains("tadilat") ||
                titleLower.contains("repair")) {
              serviceIcon = Icons.content_cut;
            } else if (titleLower.contains("koleksiyon") ||
                titleLower.contains("collection")) {
              serviceIcon = Icons.checkroom;
            }

            return Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.gold.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(serviceIcon, color: AppTheme.gold, size: 28),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          service.title.toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.gold,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          service.description,
                          maxLines: 4,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (index * 150).ms).slideX(begin: 0.05);
          },
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator(color: AppTheme.gold)),
      error: (err, stack) => Center(
          child:
              Text('Error: $err', style: const TextStyle(color: Colors.white))),
    );
  }
}
