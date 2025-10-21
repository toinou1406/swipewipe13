import 'package:go_router/go_router.dart';
import 'package:swipe_clean/features/home/presentation/screens/home_screen.dart';
import 'package:swipe_clean/features/photos/presentation/screens/album_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/albums',
      builder: (context, state) => const AlbumScreen(),
    ),
  ],
);
