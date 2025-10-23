import 'package:go_router/go_router.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/swipe_screen.dart';
import 'package:myapp/screens/albums_screen.dart';
import 'package:myapp/screens/album_detail_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/swipe',
      builder: (context, state) => const SwipeScreen(),
    ),
    GoRoute(
      path: '/albums',
      builder: (context, state) => const AlbumsScreen(),
      routes: [
        GoRoute(
          path: ':albumId',
          builder: (context, state) => AlbumDetailScreen(
            albumId: state.pathParameters['albumId']!,
          ),
        ),
      ],
    ),
  ],
);
