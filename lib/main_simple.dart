import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/data_service.dart';
import 'models/portfolio_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SimplePortfolioApp());
}

class SimplePortfolioApp extends StatelessWidget {
  const SimplePortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<PortfolioData>(
        future: DataService.loadPortfolioData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
          }

          final portfolioData = snapshot.data!;

          return Provider<PortfolioData>.value(
            value: portfolioData,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 600,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          portfolioData.personal.name,
                          style: const TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          'About Section',
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      color: Colors.orange,
                      child: Center(
                        child: Text(
                          'Experience Section',
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
