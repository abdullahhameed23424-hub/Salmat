class InfoResponse {
  final PrivacyPolicy privacyPolicy;

  final PlatformManaGer platformManager;
  final Contact contact;

  final Features features;
  final AboutUs aboutUs;

  InfoResponse({
    required this.privacyPolicy,
    required this.platformManager,
    required this.contact,
    required this.features,
    required this.aboutUs,
  });

  factory InfoResponse.fromJson(Map<String, dynamic> json) => InfoResponse(
        privacyPolicy: PrivacyPolicy.fromJson(json["privacy_policy"]),
            platformManager: PlatformManaGer.fromJson(json["owner_teacher"]),
        contact: Contact.fromJson(json["contact"]),
        features: Features.fromJson(json["features"]),
        aboutUs: AboutUs.fromJson(json["about_us"]),
      );
}

class AboutUs {
  final String image;
  final String description;

  AboutUs({
    required this.image,
    required this.description,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "description": description,
      };
}

class Contact {
  final String whatsapp;
  final String linkedin;
  final String facebook;
  final String telegram;
  final String youtube;
  final String instagram;
  final String email;
  final String phone;
  final String twitter;
  Contact({
    required this.whatsapp,
    required this.linkedin,
    required this.facebook,
    required this.telegram,
    required this.youtube,
    required this.instagram,
    required this.email,
    required this.phone,
    required this.twitter,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        whatsapp: json["whatsapp"] ?? "",
        linkedin: json["linkedin"] ?? "",
        facebook: json["facebook"] ?? "",
        telegram: json["telegram"] ?? "",
        youtube: json["youtube"] ?? "",
        instagram: json["instagram"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        twitter: json["twitter"] ?? '',
      );
}

class Features {
  final List<String> texts;

  Features({
    required this.texts,
  });

  factory Features.fromJson(Map<String, dynamic> json) {
    String? text1 = json["text1"];
    String? text2 = json["text2"];
    String? text3 = json["text3"];
    String? text4 = json["text4"];
    String? text5 = json["text5"];
    String? text6 = json["text6"];
    List<String> texts = [];
    if (text1 != null) {
      texts.add(text1);
    }
    if (text2 != null) {
      texts.add(text2);
    }
    if (text3 != null) {
      texts.add(text3);
    }
    if (text4 != null) {
      texts.add(text4);
    }
    if (text5 != null) {
      texts.add(text5);
    }
    if (text6 != null) {
      texts.add(text6);
    }

    return Features(
      texts: texts,
    );
  }
}

class PlatformManaGer {
   final String name;
  final String description;
  final String image;
  final String facebook;
  final String instagram;
  final String whatsapp;
  final String telegram;
  final String youtube;

  PlatformManaGer({
     required this.name,
    required this.description,
    required this.image,
    required this.facebook,
    required this.instagram,
    required this.whatsapp,
    required this.telegram,
    required this.youtube,
  });

  factory PlatformManaGer.fromJson(Map<String, dynamic> json) => PlatformManaGer(
  
        name: json["name"],
        description: json["description"],
        image: json["image"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        whatsapp: json["whatsapp"],
        telegram: json["telegram"],
        youtube: json["youtube"],
      );
}

class Subjects {
  final String header;
  final String image1;

  Subjects({
    required this.header,
    required this.image1,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        header: json["header"],
        image1: json["image1"],
      );
}

class PrivacyPolicy {
  final String text;

  PrivacyPolicy({required this.text});

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
        text: json["text"],
      );
}
