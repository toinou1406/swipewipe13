
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:swipe_clean/screens/albums_screen.dart';
import 'package:swipe_clean/screens/home_screen.dart';
import 'package:swipe_clean/screens/photo_viewer_screen.dart';
import 'package:swipe_clean/screens/review_screen.dart';
import 'package:swipe_clean/screens/scaffold_with_nav_bar.dart';
import 'package:swipe_clean/screens/swipe_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: '/swipe/:category',
          builder: (BuildContext context, GoRouterState state) {
            final String category = state.pathParameters['category']!;
            return SwipeScreen(category: category);
          },
        ),
        GoRoute(
          path: '/albums',
          builder: (BuildContext context, GoRouterState state) {
            return const AlbumsScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/album/:albumId',
      builder: (BuildContext context, GoRouterState state) {
        final assetPathEntity = state.extra as AssetPathEntity?;
        if (assetPathEntity == null) {
           return const Scaffold(body: Center(child: Text('Album not found')));
        }
        return PhotoViewerScreen(albumId: assetPathEntity.id, albumName: assetPathEntity.name);
      },
    ),
     GoRoute(
          path: '/review',
          builder: (BuildContext context, GoRouterState state) {
            final itemsToDelete = state.extra as List<AssetEntity>?;
            return ReviewScreen(itemsToDelete: itemsToDelete ?? []);
          },
        ),
  ],
);
