class Course {
  String? id;
  String title;
  String description;
  String instructor;
  int duration;
  String level;
  double rating;
  DateTime createdAt;

  Course({
    this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.duration,
    required this.level,
    this.rating = 0.0,
    required this.createdAt,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'instructor': instructor,
      'duration': duration,
      'level': level,
      'rating': rating,
      'createdAt': createdAt,
    };
  }

  // Create from Firestore document
  factory Course.fromMap(String id, Map<String, dynamic> map) {
    return Course(
      id: id,
      title: map['title'],
      description: map['description'],
      instructor: map['instructor'],
      duration: map['duration'],
      level: map['level'],
      rating: map['rating'],
      createdAt: map['createdAt'].toDate(),
    );
  }
}