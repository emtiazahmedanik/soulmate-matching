class GlobalUserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String ethnicity;
  final String gender;
  final String dateOfBirth;
  final String heightCm;
  final String university;
  final List<String> photos;
  final Map<String, dynamic> about; // e.g., answersMap
  final Map<String, double>? location; // {'lat': 0.0, 'long': 0.0}
  final String aboutMe;
  final Map<String, dynamic> socialMedia; // e.g., Instagram, LinkedIn links
  final String subscriptionPlan;
  final String? nationality;
  final String? weightKg;

  GlobalUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.ethnicity,
    required this.gender,
    required this.dateOfBirth,
    required this.heightCm,
    required this.university,
    required this.photos,
    required this.about,
    this.location,
    this.aboutMe = "",
    this.socialMedia = const {},
    required this.subscriptionPlan,
    required this.nationality,
    required this.weightKg,
  });

  /// Convert Firestore map to UserProfile object
  factory GlobalUserModel.fromMap(Map<String, dynamic> map) {
    return GlobalUserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      ethnicity: map['ethnicity'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      heightCm: map['heightCm'] ?? '',
      university: map['university'] ?? '',
      photos: List<String>.from(map['photos'] ?? []),
      about: Map<String, dynamic>.from(map['about'] ?? {}),
      location: map['location'] != null
          ? {
              'lat': (map['location']['lat'] ?? 0.0).toDouble(),
              'long': (map['location']['long'] ?? 0.0).toDouble(),
            }
          : null,
      aboutMe: map['about_me'] ?? '',
      socialMedia: Map<String, dynamic>.from(map['social_media'] ?? {}),
      subscriptionPlan: map['subscriptionPlan'] ?? '',
      nationality: map['nationality'] ?? '',
      weightKg: map['weightKg'],
    );
  }

  /// Convert UserProfile object to Firestore map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'uid': uid,
  //     'name': name,
  //     'email': email,
  //     'phoneNumber': phoneNumber,
  //     'ethnicity': ethnicity,
  //     'gender': gender,
  //     'dateOfBirth': dateOfBirth,
  //     'heightCm': heightCm,
  //     'university': university,
  //     'photos': photos,
  //     'about': about,
  //     'location': location,
  //     'about_me': aboutMe,
  //     'social_media': socialMedia,
  //     'subscriptionPlan': subscriptionPlan,
  //   };
  // }

  /// Calculate current age from dateOfBirth
  int get age {
    try {
      final dob = DateTime.parse(dateOfBirth);
      final today = DateTime.now();
      int calculatedAge = today.year - dob.year;

      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        calculatedAge--;
      }

      return calculatedAge;
    } catch (e) {
      return 0; // fallback if parsing fails
    }
  }
}
