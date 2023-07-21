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
    image: "hos1.jpg",
    keywords: ["General", "Surgery"],
  ),
  Hospital(
    name: "Hospital 2",
    specialty: "Heart",
    image: "hospital2.jpg",
    keywords: ["Heart", "Surgery"],
  ),
  // Add more hospital data here
];
