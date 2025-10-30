import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // keep final which do not want to update
  final String id;
  String name;
  final String email;
  String phoneNumber;
  String profilePicture;
  String publicId;

  String ethnicity;
  String gender;
  String dateOfBirth; 
  double heightCm;
  String university;
  List<String> photos; 
  List<Map<String, dynamic>> about; 
  String subscriptionPlan;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profilePicture = '',
    this.publicId = '',
    this.ethnicity = '',
    this.gender = '',
    this.dateOfBirth = '',
    this.heightCm = 0.0,
    this.university = '',
    this.photos = const [],
    this.about = const [],
    this.subscriptionPlan = 'free',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'publicId': publicId,
      'ethnicity': ethnicity,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'heightCm': heightCm,
      'university': university,
      'photos': photos,
      'about': about,
      'subscriptionPlan': subscriptionPlan,
    };
  }

    /// static function to create an empty user model
  static UserModel empty() => UserModel(
    id: "",
    name: "",
    email: "",
    phoneNumber: "",
  );

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        publicId: data['publicId'] ?? '',
        ethnicity: data['ethnicity'] ?? '',
        gender: data['gender'] ?? '',
        dateOfBirth: data['dateOfBirth'] ?? '',
        heightCm: (data['heightCm'] ?? 0).toDouble(),
        university: data['university'] ?? '',
        photos: data['photos'] != null ? List<String>.from(data['photos']) : [],
        about: data['about'] != null
            ? List<Map<String, dynamic>>.from(data['about'])
            : [],
        subscriptionPlan: data['subscriptionPlan'] ?? 'free',
      );
    } else {
      return UserModel.empty();
    }
  }
}
