import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/portfolio_models.dart';
import '../widgets/animated_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> 
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _socialController;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _socialController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    _socialController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        final contact = portfolioData.contact;
        
        if (contact == null) return const SizedBox.shrink();

        return Container(
          key: contactKey,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1E293B).withOpacity(0.8),
                const Color(0xFF0F172A),
              ],
            ),
          ),
          child: Column(
            children: [
              // Section Header
              _buildSectionHeader(),
              
              const SizedBox(height: 80),
              
              // Content
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 768) {
                    // Desktop layout
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contact Form
                        Expanded(
                          flex: 3,
                          child: _buildContactForm(contact),
                        ),
                        const SizedBox(width: 60),
                        // Contact Info & Social
                        Expanded(
                          flex: 2,
                          child: _buildContactInfo(contact),
                        ),
                      ],
                    );
                  } else {
                    // Mobile layout
                    return Column(
                      children: [
                        _buildContactForm(contact),
                        const SizedBox(height: 60),
                        _buildContactInfo(contact),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'GET IN TOUCH',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 2,
          ),
        ).animate().slideY(
          duration: 600.ms,
          begin: -0.3,
          curve: Curves.easeOutCubic,
        ).fadeIn(),
        
        const SizedBox(height: 16),
        
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.purple.withOpacity(0.8),
              ],
            ),
          ),
        ).animate().scaleX(
          duration: 800.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
    );
  }

  Widget _buildContactForm(Contact contact) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.title,
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate().slideX(
              duration: 600.ms,
              begin: -0.3,
              curve: Curves.easeOutCubic,
            ).fadeIn(),
            
            const SizedBox(height: 16),
            
            SizedBox(
              width: constraints.maxWidth > 768 ? 500 : double.infinity,
              child: Text(
                contact.description,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.6,
                ),
              ),
            ).animate().slideX(
              duration: 600.ms,
              delay: 100.ms,
              begin: -0.3,
              curve: Curves.easeOutCubic,
            ).fadeIn(delay: 100.ms),
            
            const SizedBox(height: 40),
            
            // Contact Form
            GlassmorphicContainer(
              width: double.infinity,
              height: constraints.maxWidth > 768 ? 500 : 600,
              borderRadius: 20,
              blur: 10,
              alignment: Alignment.center,
              border: 1,
              linearGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.white.withOpacity(0.02),
                ],
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      _buildTextField(
                        controller: _nameController,
                        label: 'Your Name',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Email Field
                      _buildTextField(
                        controller: _emailController,
                        label: 'Your Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@[\w-]+\.[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Message Field
                      _buildTextField(
                        controller: _messageController,
                        label: 'Your Message',
                        icon: Icons.message,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Submit Button
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                duration: 2000.ms,
                delay: 400.ms,
                begin: Offset(1.0, 1.0),
                end: Offset(1.01, 1.01),
              )
              .then()
              .shimmer(
                duration: 2000.ms,
                delay: 1400.ms,
              ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: Colors.white.withOpacity(0.9),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.white.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white.withOpacity(0.6),
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue.withOpacity(0.6),
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
    ).animate().slideX(
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    ).fadeIn();
  }

  Widget _buildSubmitButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _submitForm,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.purple.withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'SEND MESSAGE',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          duration: 2000.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.02, 1.02),
        ),
    );
  }

  Widget _buildContactInfo(Contact contact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Social Links
        Text(
          'CONNECT',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 2,
          ),
        ).animate().slideY(
          duration: 600.ms,
          begin: -0.3,
          curve: Curves.easeOutCubic,
        ).fadeIn(),
        
        const SizedBox(height: 24),
        
        // Social Links Grid
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: contact.socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final social = entry.value;
            
            return _buildSocialCard(social, index);
          }).toList(),
        ),
        
        const SizedBox(height: 40),
        
        // Additional Info
        _buildInfoCard(
          'Email',
          'john.doe@email.com',
          Icons.email,
          Colors.blue,
        ).animate().slideX(
          duration: 600.ms,
          delay: 800.ms,
          begin: 0.3,
          curve: Curves.easeOutCubic,
        ).fadeIn(delay: 800.ms),
        
        const SizedBox(height: 16),
        
        _buildInfoCard(
          'Location',
          'San Francisco, CA',
          Icons.location_on,
          Colors.purple,
        ).animate().slideX(
          duration: 600.ms,
          delay: 900.ms,
          begin: 0.3,
          curve: Curves.easeOutCubic,
        ).fadeIn(delay: 900.ms),
      ],
    );
  }

  Widget _buildSocialCard(SocialLink social, int index) {
    final delay = (index * 100).ms;
    final iconData = _getIconData(social.icon);
    final iconColor = _getIconColor(social.icon);
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(social.url),
        child: GlassmorphicContainer(
          width: 120,
          height: 120,
          borderRadius: 20,
          blur: 10,
          alignment: Alignment.center,
          border: 1,
          linearGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
            ],
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.1),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                iconData,
                size: 32,
                color: iconColor.withOpacity(0.8),
              ),
              const SizedBox(height: 8),
              Text(
                social.platform,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            duration: 2000.ms,
            delay: delay + 1000.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.05, 1.05),
          ),
      ).animate().scale(
        duration: 300.ms,
        delay: delay,
        curve: Curves.easeOutBack,
      ).fadeIn(delay: delay),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
      borderRadius: 16,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.05),
          Colors.white.withOpacity(0.02),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.1),
                  ],
                ),
              ),
              child: Icon(
                icon,
                color: color.withOpacity(0.8),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'github':
        return FontAwesomeIcons.github;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'email':
        return FontAwesomeIcons.envelope;
      default:
        return FontAwesomeIcons.link;
    }
  }

  Color _getIconColor(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'linkedin':
        return Colors.blue;
      case 'github':
        return Colors.white;
      case 'twitter':
        return Colors.lightBlue;
      case 'email':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Thank you for your message! I\'ll get back to you soon.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
