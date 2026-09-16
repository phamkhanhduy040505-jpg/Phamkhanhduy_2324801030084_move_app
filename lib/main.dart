import 'package:flutter/material.dart';

void main() {
  runApp(const CinemaApp());
}

// ==========================================
// 1. DATA MODELS (Mô hình dữ liệu)
// ==========================================
class Movie {
  final String id;
  final String title;
  final String rating;
  final String categoryId;
  final String description;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.categoryId,
    required this.description,
    required this.posterUrl,
  });
}

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

// ==========================================
// 2. MOCK DATA (Dữ liệu mẫu)
// ==========================================
final List<Category> mockCategories = [
  Category(id: 'c1', name: 'Viễn Tưởng', icon: Icons.rocket_launch, color: Colors.blue),
  Category(id: 'c2', name: 'Hành Động', icon: Icons.local_fire_department, color: Colors.red),
  Category(id: 'c3', name: 'Kinh Dị', icon: Icons.bug_report, color: Colors.purple),
  Category(id: 'c4', name: 'Tình Cảm', icon: Icons.favorite, color: Colors.pink),
];

final List<Movie> mockMovies = [
  Movie(
    id: 'm1',
    title: 'Inception',
    rating: '8.8',
    categoryId: 'c1',
    description: 'Dom Cobb là tên trộm bậc thầy chuyên đánh cắp bí mật từ tiềm thức người khác.',
    posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=800&auto=format&fit=crop',
  ),
  Movie(
    id: 'm2',
    title: 'Interstellar',
    rating: '8.7',
    categoryId: 'c1',
    description: 'Một nhóm nhà thám hiểm du hành qua lỗ sâu vũ trụ để tìm kiếm sự sống mới.',
    posterUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=800&auto=format&fit=crop',
  ),
  Movie(
    id: 'm3',
    title: 'Cyberpunk City',
    rating: '9.0',
    categoryId: 'c2',
    description: 'Cuộc chiến sinh tồn trong thành phố tương lai rực rỡ ánh đèn neon.',
    posterUrl: 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=800&auto=format&fit=crop',
  ),
  Movie(
    id: 'm4',
    title: 'Nightmare Haunted',
    rating: '7.9',
    categoryId: 'c3',
    description: 'Bí ẩn đằng sau ngôi nhà hoang bí ẩn nơi ngoại ô thành phố.',
    posterUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=800&auto=format&fit=crop',
  ),
];

// ==========================================
// 3. ROOT APP VÀ ROUTING CONFIG
// ==========================================
class CinemaApp extends StatelessWidget {
  const CinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinema Hub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainShellScreen(),
        '/details': (context) => const DetailScreen(),
        '/category-movies': (context) => const CategoryMoviesScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

// ==========================================
// 4. MAIN SHELL SCREEN (Chứa BottomNav + Drawer)
// ==========================================
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const CategoriesTab(),
    const FavoritesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinema Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          )
        ],
      ),
      // --- DRAWER (Menu bên) ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Phạm Khánh Duy', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('2324801030084@student.tdmu.edu.vn'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text('A', style: TextStyle(fontSize: 24, color: Colors.white)),
              ),
              decoration: BoxDecoration(color: Color(0xFF1E1E1E)),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.redAccent),
              title: const Text('Trang chủ'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Colors.blue),
              title: const Text('Danh mục phim'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: const Text('Trang cá nhân'),
              onTap: () {
                Navigator.pop(context); // Đóng drawer trước khi chuyển trang
                Navigator.pushNamed(context, '/profile');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.grey),
              title: const Text('Đăng xuất'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      // --- NỘI DUNG THAY ĐỔI THEO TAB ---
      body: _pages[_currentIndex],
      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF1E1E1E),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Danh mục'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Yêu thích'),
        ],
      ),
    );
  }
}

// ==========================================
// 5. CÁC TAB NỘI DUNG (Home, Category, Favorite)
// ==========================================

// TAB 1: TRANG CHỦ
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Thể Loại Nổi Bật', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // Danh mục cuộn ngang
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mockCategories.length,
            itemBuilder: (context, index) {
              final cat = mockCategories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ActionChip(
                  avatar: Icon(cat.icon, size: 16, color: Colors.white),
                  label: Text(cat.name),
                  backgroundColor: cat.color.withOpacity(0.2),
                  onPressed: () {
                    Navigator.pushNamed(context, '/category-movies', arguments: cat);
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const Text('Phim Mới Nhất', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // Danh sách phim
        ...mockMovies.map((movie) => _buildMovieCard(context, movie)),
      ],
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Hero(
          tag: 'poster-${movie.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(movie.posterUrl, width: 60, height: 90, fit: BoxFit.cover),
          ),
        ),
        title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('★ ${movie.rating}', style: const TextStyle(color: Colors.amber)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, '/details', arguments: movie);
        },
      ),
    );
  }
}

// TAB 2: MÀN HÌNH DANH MỤC (GRID VIEW)
class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
      ),
      itemCount: mockCategories.length,
      itemBuilder: (context, index) {
        final cat = mockCategories[index];
        return InkWell(
          onTap: () {
            // Truyền đối tượng Category sang màn hình danh sách phim
            Navigator.pushNamed(context, '/category-movies', arguments: cat);
          },
          child: Container(
            decoration: BoxDecoration(
              color: cat.color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cat.color, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cat.icon, size: 40, color: cat.color),
                const SizedBox(height: 8),
                Text(cat.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// TAB 3: YÊU THÍCH
class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Chưa có phim yêu thích nào', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// ==========================================
// 6. MÀN HÌNH MỚI 1: DANH SÁCH PHIM THEO DANH MỤC
// ==========================================
class CategoryMoviesScreen extends StatelessWidget {
  const CategoryMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Nhận dữ liệu Category được truyền qua Arguments
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    // Lọc danh sách phim theo categoryId
    final categoryMovies = mockMovies.where((m) => m.categoryId == category.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Phim: ${category.name}'),
      ),
      body: categoryMovies.isEmpty
          ? const Center(child: Text('Chưa có phim cho thể loại này'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoryMovies.length,
              itemBuilder: (context, index) {
                final movie = categoryMovies[index];
                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Image.network(movie.posterUrl, width: 50, fit: BoxFit.cover),
                    title: Text(movie.title),
                    subtitle: Text(movie.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      Navigator.pushNamed(context, '/details', arguments: movie);
                    },
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// 7. MÀN HÌNH MỚI 2: TRANG CÁ NHÂN (PROFILE)
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Cá Nhân')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Phạm Khánh Duy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('2324801030084@student.tdmu.edu.vn', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text('Quay lại', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 8. MÀN HÌNH CHI TIẾT PHIM (DETAIL SCREEN)
// ==========================================
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              background: Hero(
                tag: 'poster-${movie.id}',
                child: Image.network(movie.posterUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Đánh giá: ★ ${movie.rating}', style: const TextStyle(fontSize: 18, color: Colors.amber)),
                  const SizedBox(height: 16),
                  const Text('Nội dung:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(movie.description, style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}