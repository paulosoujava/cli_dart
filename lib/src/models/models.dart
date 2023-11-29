import 'dart:convert';

class Student {
  final int? id;
  final String name;
  final List<String> nameCourses;
  final List<Course> courses;
  final Address address;

  Student(
      {this.id,
      required this.address,
      required this.courses,
      required this.name,
      required this.nameCourses});

  toMap() {
    return {
      'id': id,
      'name': name,
      'nameCourses': nameCourses,
      'courses': courses.map((e) => e.toMap()).toList(),
      'address': address.toMap()
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      nameCourses: List<String>.from(map['nameCourse'] ?? []),
      courses: (map['courses'] as List<dynamic>?)
              ?.map<Course>((courseMap) => Course.fromMap(courseMap))
              .toList() ??
          [],
      //ou
      //course: map['course']?.map<Course>((course) => Course.fromMap(course)).toList() ?? <Course> []
      address: Address.fromMap(map['address']),
    );
  }
  factory Student.fromJson(String json) => Student.fromJson(json);

  @override
  String toString() {
    return "Student(id: $id, name: $name, nameCourses: $nameCourses, courses: $courses, address: $address)";
  }
}

class Course {
  final int id;
  final String name;
  bool isStudent;

  Course({required this.id, required this.isStudent, required this.name});
  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) => Course(
        id: map['id'] ?? 0,
        name: map['name'] ?? "",
        isStudent: map['isStudent'] ?? false,
      );

  factory Course.fromJson(String json) => Course.fromMap(jsonDecode(json));
}

class Address {
  final String street;
  final int number;
  final String zipCode;
  final City city;
  final Phone phone;

  Address(
      {required this.street,
      required this.number,
      required this.zipCode,
      required this.city,
      required this.phone});

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) => Address(
        street: map['street'] ?? "",
        number: map['number'] ?? 0,
        zipCode: map['zipCode'] ?? "",
        city: City.fromMap(map['city'] ?? <String, dynamic>{}),
        phone: Phone.fromMap(map['phone'] ?? <String, dynamic>{}),
      );

  factory Address.fromJson(String json) => Address.fromMap(jsonDecode(json));
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory City.fromMap(Map<String, dynamic> map) =>
      City(id: map['id'] ?? 0, name: map['name'] ?? "");

  factory City.fromJson(String json) => City.fromMap(jsonDecode(json));
}

class Phone {
  final int ddd;
  final String phone;

  Phone({required this.ddd, required this.phone});

  Map<String, dynamic> toMap() {
    return {'ddd': ddd, 'phone': phone};
  }

  String toJson() => jsonEncode(toMap());

  factory Phone.fromMap(Map<String, dynamic> map) =>
      Phone(ddd: map['ddd'] ?? 0, phone: map['phone'] ?? "");

  factory Phone.fromJson(String json) => Phone.fromMap(jsonDecode(json));
}
