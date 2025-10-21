import 'package:sparkle/models/album.dart';
import 'package:sparkle/models/media.dart';

class Database {
  // Singleton pattern to ensure only one instance of the database is created
  static final Database _instance = Database._internal();
  factory Database() => _instance;
  Database._internal();

  // In-memory data storage (replace with a persistent storage solution later)
  final List<Album> _albums = [];
  final List<Media> _media = [];

  // Methods to interact with the data
  List<Album> get albums => _albums;
  List<Media> get media => _media;

  void addAlbum(Album album) {
    _albums.add(album);
  }

  void addMedia(Media media) {
    _media.add(media);
  }

  // Add more methods for updating, deleting, and querying data as needed
}
