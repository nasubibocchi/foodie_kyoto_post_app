import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
