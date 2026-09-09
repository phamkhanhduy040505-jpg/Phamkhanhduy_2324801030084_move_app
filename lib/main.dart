import 'package:flutter/material.dart';

void main() {
  runApp(const CinemaApp());
}

class Movie {
  final String id;
  final String title;
  final String rating;
  final String genre;
  final String description;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.genre,
    required this.description,
    required this.posterUrl,
  });
}

class CinemaApp extends StatelessWidget {
  const CinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinema App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu ảnh HD nét cao từ Unsplash
    final List<Movie> movies = [
      Movie(
        id: '1',
        title: 'Inception',
        rating: '8.8',
        genre: 'Sci-Fi / Action',
        description: 'Dom Cobb là một tên trộm bậc thầy chuyên đánh cắp các bí mật vô giá từ sâu trong tiềm thức của mục tiêu khi họ đang trong giấc mơ.',
        posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=800&auto=format&fit=crop',
      ),
      Movie(
        id: '2',
        title: 'Interstellar',
        rating: '8.7',
        genre: 'Sci-Fi / Drama',
        description: 'Khi Trái Đất không còn là nơi có thể sống được, một nhóm nhà thám hiểm phải sử dụng một lỗ sâu mới được khám phá để vượt qua các giới hạn du hành vũ trụ.',
        posterUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=800&auto=format&fit=crop',
      ),
      Movie(
        id: '3',
        title: 'Cyberpunk City',
        rating: '9.0',
        genre: 'Action / Fantasy',
        description: 'Hành trình sinh tồn của một lính đánh thuê trong tương lai, nơi công nghệ sinh học và tội phạm kiểm soát toàn bộ thành phố.',
        posterUrl: 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=800&auto=format&fit=crop',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phim Đang Chiếu', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: movie);
              },
              child: Row(
                children: [
                  // Hero Widget 1: Áp dụng hiệu ứng phóng to ảnh
                  Hero(
                    tag: 'movie-poster-${movie.id}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.network(
                        movie.posterUrl,
                        width: 110,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(movie.rating, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 12),
                              Text(movie.genre, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            movie.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Hero Widget 2: Trùng tag để khớp hiệu ứng chuyển cảnh
                  Hero(
                    tag: 'movie-poster-${movie.id}',
                    child: Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Lớp phủ tối mờ phía dưới để chữ hiển thị rõ
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '★ ${movie.rating}',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Chip(
                        label: Text(movie.genre),
                        backgroundColor: const Color(0xFF2C2C2C),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nội dung phim',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.description,
                    style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: const Text('Xem Trailer', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}