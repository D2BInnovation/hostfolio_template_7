import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/data_service.dart';
import 'utils/scroll_controller.dart';
import 'widgets/animated_header.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'models/portfolio_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const HostFolioApp());
}

class HostFolioApp extends StatelessWidget {
  const HostFolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PortfolioData>(
      future: DataService.loadPortfolioData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoadingScreen(),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ErrorScreen(error: snapshot.error.toString()),
          );
        }

        final portfolioData = snapshot.data!;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AppScrollController()),
            Provider<PortfolioData>.value(value: portfolioData),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: portfolioData.personal.name,
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.interTextTheme(),
              scaffoldBackgroundColor: const Color(0xFF0F172A),
            ),
            home: const PortfolioHomePage(),
          ),
        );
      },
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollController = Provider.of<AppScrollController>(context, listen: false);
      scrollController.controller.addListener(_onScroll);
    });
  }

  void _onScroll() {
    // Handle scroll events if needed
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content with scroll
          Consumer<AppScrollController>(
            builder: (context, scrollController, child) {
              return SingleChildScrollView(
                controller: scrollController.controller,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Hero Section (always present if data exists)
                    Consumer<PortfolioData>(
                      builder: (context, portfolioData, child) {
                        return portfolioData.hero != null
                            ? HeroSection(key: heroKey) // Assign global key
                            : const SizedBox.shrink();
                      },
                    ),
                    
                    // About Section
                    Consumer<PortfolioData>(
                      builder: (context, portfolioData, child) {
                        return portfolioData.about != null
                            ? const AboutSection()
                            : const SizedBox.shrink();
                      },
                    ),
                    
                    // Experience Section
                    Consumer<PortfolioData>(
                      builder: (context, portfolioData, child) {
                        final experience = portfolioData.experience;
                        return experience != null && 
                                   experience.isNotEmpty
                            ? const ExperienceSection()
                            : const SizedBox.shrink();
                      },
                    ),
                    
                    // Projects Section
                    Consumer<PortfolioData>(
                      builder: (context, portfolioData, child) {
                        final projects = portfolioData.projects;
                        return projects != null && 
                                   projects.isNotEmpty
                            ? const ProjectsSection()
                            : const SizedBox.shrink();
                      },
                    ),
                    
                    // Contact Section
                    Consumer<PortfolioData>(
                      builder: (context, portfolioData, child) {
                        final contact = portfolioData.contact;
                        return contact != null
                            ? const ContactSection()
                            : const SizedBox.shrink();
                      },
                    ),
                    
                    // Footer
                    _buildFooter(),
                  ],
                ),
              );
            },
          ),
          
          // Animated Header (always on top)
          const AnimatedHeader(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F172A),
                const Color(0xFF000000),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Divider
              Container(
                width: 60,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Copyright
              Text(
                '© ${DateTime.now().year} ${portfolioData.personal.name}. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Built with love
              Text(
                'Built with Flutter and ❤️',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> 
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(_opacityAnimation.value),
                          Colors.purple.withOpacity(_opacityAnimation.value),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.code,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Loading Portfolio...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(_opacityAnimation.value),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                error,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HostFolioApp(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
