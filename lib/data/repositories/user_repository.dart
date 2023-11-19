import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/models/model_user.dart';

class UserRepository {
  static Future<void> saveUserData(UserModel user) async {
    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userDocument =
          userCollection.doc(FirebaseAuth.instance.currentUser!.uid);
      final Map<String, dynamic> userMap = {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'image': ''
      };
      await userDocument.set(userMap);
      log('User saved');
    } catch (e) {
      print('Error saving user data: ${e.toString()}');
    }
  }

  static Future<String> getCurrentUserName(String uid) async {
    try {
      final userDocument =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDocument.exists) {
        final userName = userDocument.data()!['name'];
        return userName;
      } else {
        return 'Unknown User';
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return 'Unknown User';
    }
  }

  static Future<UserModel> getCurrentUserById(String uid) async {
    try {
      final userDocument =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDocument.exists) {
        final user = userDocument.data();
        return UserModel.fromJson(user!);
      } else {
        throw Exception();
      }
    } catch (e) {
      log('Error fetching user data: $e');
      throw Exception();
    }
  }

  static Future<File?> selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  static Future<void> uploadProfileImageToFirebase(
      String userId, File imageFile) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');

    final UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      final imageUrl = await storageReference.getDownloadURL();
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({'image': imageUrl});
    });

    print('Image uploaded and user document updated');
  }

  static Stream<String> getProfileImageUrl(String userId) async* {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final imageUrl =
          userDoc.data()?['image'] as String? ?? ''; // Provide a default value
      yield imageUrl;
    } catch (e) {
      print('Error fetching profile image URL: $e');
      yield ''; // Provide a default value in case of an error
    }
  }

  static Future<List<Car>> userCars(String userId) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference userDoc = users.doc(userId);
      final CollectionReference carsCollection = userDoc.collection('cars');

      final QuerySnapshot carSnapshot = await carsCollection.get();

      return carSnapshot.docs.map((carDoc) {
        final data = carDoc.data() as Map<String, dynamic>;
        return Car(
          make: data['make'],
          model: data['model'],
          year: data['year'],
          fuel: data['fuel'],
          licensePlate: data['regNumber'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching user cars: $e');
      return [];
    }
  }

  static Future<void> addCarsForUser(
      {required String userId, required Car car}) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference userDoc = users.doc(userId);
      final CollectionReference carCollection = userDoc.collection('cars');

      await carCollection.add({
        'make': car.make,
        'model': car.model,
        'year': car.year,
        'fuel': car.fuel,
        'regNumber': car.licensePlate,
      });
    } catch (e) {
      log('Error : $e');
    }
  }

  static Future<void> deleteCarForUser(
      {required String userId, required String carId}) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference userDoc = users.doc(userId);
      final CollectionReference carCollection = userDoc.collection('cars');

      // Delete the car document with the specified carId
      await carCollection.doc(carId).delete();
    } catch (e) {
      log('Error: $e');
    }
  }

  static Stream<List<Car>> streamUserCars(String userId) {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final DocumentReference userDoc = users.doc(userId);
    final CollectionReference carsCollection = userDoc.collection('cars');

    return carsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((carDoc) {
        final data = carDoc.data() as Map<String, dynamic>;
        return Car(
          make: data['make'],
          model: data['model'],
          year: data['year'],
          fuel: data['fuel'],
          licensePlate: data['regNumber'],
        );
      }).toList();
    });
  }

  // To get details of a specific car by license plate number
  static Future<Car?> getCarByLicensePlate(
      {required String userId, required String licensePlate}) async {
    final users = FirebaseFirestore.instance.collection('users');
    final userDoc = users.doc(userId);
    final carsCollection = userDoc.collection('cars');

    try {
      final querySnapshot = await carsCollection
          .where('regNumber', isEqualTo: licensePlate)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        print(data);
        return Car.fromJson(data);
      } else {
        return null; // Car with the given license plate not found.
      }
    } catch (e) {
      print('Error is: $e');
      return null;
    }
  }

  //////////
  Future<void> removeCarFromFirebase({
    required String userId,
    required String licensePlate,
  }) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference userDoc = users.doc(userId);
      final CollectionReference carsCollection = userDoc.collection('cars');

      // Query the car with the specified license plate
      final querySnapshot = await carsCollection
          .where('regNumber', isEqualTo: licensePlate)
          .get();

      // If there is a matching car, delete it
      if (querySnapshot.docs.isNotEmpty) {
        final carId = querySnapshot.docs.first.id;
        await carsCollection.doc(carId).delete();
        print('Car removed from Firebase');
      } else {
        print('Car with the specified license plate not found.');
      }
    } catch (e) {
      print('Error removing car from Firebase: $e');
      // Handle the error as needed
    }
  }
}
