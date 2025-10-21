import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sparkle/screens/home_screen.dart';
import 'package:sparkle/screens/album_screen.dart';
import 'package:sparkle/screens/media_viewer_screen.dart';
import 'package:sparkle/screens/album_details_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'album',
          builder: (BuildContext context, GoRouterState state) {
            return const AlbumScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'details',
              builder: (BuildContext context, GoRouterState state) {
                final AssetPathEntity album = state.extra as AssetPathEntity;
                return AlbumDetailsScreen(album: album);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'media',
          builder: (BuildContext context, GoRouterState state) {
            final AssetEntity media = state.extra as AssetEntity;
            return MediaViewerScreen(media: media);
          },
        ),
      ],
    ),
  ],
);
