import 'package:flutter/material.dart';
import 'package:zamzam/features/company_feature/model/company_model.dart';
import 'package:zamzam/features/company_feature/model/offers_model.dart';
import 'package:zamzam/features/company_feature/service/company_service.dart';
import 'package:zamzam/features/company_feature/service/offers_service.dart';

import 'package:zamzam/features/company_feature/favourite/favourite_page.dart';
import 'package:zamzam/features/company_feature/ui/detalies_page.dart'; // اضفنا صفحة المفضلة

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CompanyService companyService = CompanyService();
  OffersService offersService = OffersService();
  List<CompanyModel> companies = [];
  List<OffersModel> offers = [];

  int limit = 10;
  int skip = 0;
  bool isLoading = false;
  int? selectedCompanyId;

  int _selectedIndex = 0; // لمتابعة الزر المختار

  @override
  void initState() {
    super.initState();
    fetchCompanies();
    fetchOffers();
  }

  Future<void> fetchCompanies() async {
    setState(() => isLoading = true);
    List<CompanyModel> fetchedCompanies = await companyService.getCompanies(limit: limit, skip: skip);
    setState(() {
      companies.addAll(fetchedCompanies);
      isLoading = false;
    });
  }

  Future<void> fetchOffers({int? companyId}) async {
    setState(() {
      isLoading = true;
      skip = 0;
      selectedCompanyId = companyId;
    });

    try {
      List<OffersModel> fetchedOffers;
      if (companyId == null) {
        fetchedOffers = await offersService.getAllOffers(limit: limit, skip: skip);
      } else {
        fetchedOffers = await offersService.getOffersByCompanyId(
          companyId: companyId,
          limit: limit,
          skip: skip,
        );
      }

      setState(() {
        offers = fetchedOffers;
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  FavoritesPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTopBar(),
                  const SizedBox(height: 20),
                  buildPromoBanner(screenWidth),
                  const SizedBox(height: 20),
                  buildCompanyFilters(),
                  const SizedBox(height: 20),
                  buildOffersGrid(crossAxisCount),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Back!', style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 5),
          Text('Mr Product!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for water...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPromoBanner(double screenWidth) {
    return Container(
      height: screenWidth * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.lightBlue[300],
        image: DecorationImage(
          image: AssetImage('images/zamzam.jpg'),
          fit: BoxFit.cover,
          onError: (error, stackTrace) => Container(color: Colors.blueAccent),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Drips Springs', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Bottle Water Delivery', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Catch Shop'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompanyFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          filterButton('All', selectedCompanyId == null, onTap: () {
            fetchOffers();
          }),
          ...companies.map((company) => filterButton(company.name, selectedCompanyId == company.id, onTap: () {
            fetchOffers(companyId: company.id);
          })).toList(),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget filterButton(String label, bool isSelected, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildOffersGrid(int crossAxisCount) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: GridView.builder(
        key: ValueKey(offers.length),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: offers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final offer = offers[index];
          return productOfferCard(offer);
        },
      ),
    );
  }

  Widget productOfferCard(OffersModel offer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              title: offer.title ?? 'No Title',
              price: offer.price ?? 0.0,
              description: offer.description ?? 'No description available.',
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.asset(
                    'images/zam.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(Icons.local_drink, color: Colors.blue, size: 50),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title ?? 'No Title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${offer.price?.toStringAsFixed(2) ?? '0.00'} ',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
