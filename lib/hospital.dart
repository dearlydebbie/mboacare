class Hospital {
  final String name;
  final String specialty;
  final String image;
  final List<String> keywords;

  Hospital({
    required this.name,
    required this.specialty,
    required this.image,
    required this.keywords,
  });
}

final List<Hospital> hospitals = [
  Hospital(
    name: "Hospital 1",
    specialty: "General Medicine",
    image: "lib/assests/images/aiims.jpg",
    keywords: ["General", "Surgery"],
  ),
  Hospital(
    name: "Hospital 2",
    specialty: "Cardiology",
    image: "lib/assests/images/apollo.jpg",
    keywords: ["Cardiology", "Surgery"],
  ),
  // Add more hospital data here
];
