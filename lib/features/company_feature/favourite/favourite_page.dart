import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zamzam/features/company_feature/favourite/favourite_manager.dart';
import 'package:zamzam/features/company_feature/ui/detalies_page.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward(); // نشغل الأنيميشن لما الصفحة تفتح
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color.fromARGB(0, 224, 215, 215),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2196F3), // أزرق
              Colors.white,       // أبيض
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('favorites').listenable(),
          builder: (context, Box box, _) {
            if (box.isEmpty) {
              return const Center(
                child: Text(
                  'No favorites yet!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            final favorites = FavoriteManager.getFavorites();

            return Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16, right: 16),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final product = favorites[index];

                  return Dismissible(
                    key: Key(product['title'] + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white, size: 30),
                    ),
                    onDismissed: (direction) {
                      box.deleteAt(index);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product['title']} removed from favorites'),
                          backgroundColor: Colors.redAccent,
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                    child: FadeScaleTransition(
                      animation: CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          (index / favorites.length),
                          1.0,
                          curve: Curves.easeOut,
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            product['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          subtitle: Text(
                            '\$${product['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                          trailing: const Icon(Icons.favorite, color: Colors.red),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  title: product['title'],
                                  price: product['price'],
                                  description: product['description'],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class FadeScaleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const FadeScaleTransition({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
