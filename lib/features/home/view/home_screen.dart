import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Instagram ikonu için
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme.dart';
import '../provider/service_provider.dart';
import '../widgets/faq_section.dart'; // YENİ
import '../widgets/gallery_section.dart';
import '../widgets/google_map_section.dart';
import '../widgets/process_section.dart'; // YENİ

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey _koleksiyonKey = GlobalKey();
  final GlobalKey _hizmetlerKey = GlobalKey();

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

  void _launchWhatsApp() async {
    const phone = "905439255608";
    const message =
        "Merhaba, Serpil Moda Evi web sitenizden ulaşıyorum. Bilgi ve randevu almak istiyorum.";
    final url =
        Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  // Instagram yönlendirmesi için fonksiyon
  void _launchInstagram() async {
    final url = Uri.parse(
        "https://www.instagram.com/serpilmodaevi_bursa"); // Gerçek linki buraya yazarsın
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
        label: const Text("Bilgi & Randevu",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ).animate().scale(delay: 2.seconds),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        elevation: 0,
        title: const Text(
          'SERPİL MODA EVİ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              color: AppTheme.gold),
        ).animate().fadeIn(duration: 800.ms),
        actions: [
          _navButton("KOLEKSİYON", () => _scrollToSection(_koleksiyonKey)),
          _navButton("HİZMETLERİMİZ", () => _scrollToSection(_hizmetlerKey)),
          _navButton("İLETİŞİM", _launchWhatsApp),
          // Instagram İkonu
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

            // 1. KOLEKSİYON BÖLÜMÜ
            GallerySection(key: _koleksiyonKey),

            const SizedBox(height: 80),

            // 2. SÜREÇ BÖLÜMÜ (NASIL ÇALIŞIYORUZ?)
            const ProcessSection(),

            const SizedBox(height: 100),

            // 3. HİZMETLER BÖLÜMÜ
            _buildServicesHeader(context),
            _buildServicesSection(context, servicesAsync),

            const SizedBox(height: 80),

            // 4. SSS BÖLÜMÜ (SIKÇA SORULAN SORULAR)
            const FAQSection(),

            const SizedBox(height: 100),

            // 5. HARİTA VE İLETİŞİM
            const GoogleMapSection(),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  // --- Widget Metotları (Hero, About, Services vb.) aynı kalıyor ---

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
          Text("Usta Ellerde\nKişiye Özel Zarafet",
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
            child: const Text("KOLEKSİYONU KEŞFET",
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
          const Text("TERZİLİK SANATI",
              style: TextStyle(
                  color: AppTheme.gold, fontSize: 13, letterSpacing: 6)),
          const SizedBox(height: 25),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Text(
              "Serpil Moda Evi olarak, kumaşa ruh katan usta ellerimizle 20 yılı aşkın süredir hikayenizi dikiyoruz. Sadece bir kıyafet değil, özgüveninizi ve zarafetinizi yansıtan eşsiz birer eser ortaya çıkarmak için her dikişte titizlikle çalışıyoruz.",
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
        const Text("ERKEK & KADIN TERZİ SANATI",
            style: TextStyle(
                color: AppTheme.gold, fontSize: 13, letterSpacing: 5)),
        const SizedBox(height: 15),
        Text("Kişiye Özel Kesim, Kusursuz Form",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 28, fontWeight: FontWeight.w300)),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Atölyemizde hem erkek hem kadın giyiminde klasik terzilik disiplinini modern tasarımlarla birleştiriyoruz.",
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
            child: Text("Hizmetler yükleniyor...",
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

            if (titleLower.contains("takım")) {
              serviceIcon = Icons.straighten;
            } else if (titleLower.contains("abiye")) {
              serviceIcon = Icons.auto_awesome;
            } else if (titleLower.contains("tadilat")) {
              serviceIcon = Icons.content_cut;
            } else if (titleLower.contains("koleksiyon")) {
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
              Text('Hata: $err', style: const TextStyle(color: Colors.white))),
    );
  }
}
