// To parse this JSON data, do
//
//     final publicProfileResponse = publicProfileResponseFromJson(jsonString);

import 'dart:convert';

PublicProfileResponse publicProfileResponseFromJson(String str) =>
    PublicProfileResponse.fromJson(json.decode(str));

String publicProfileResponseToJson(PublicProfileResponse data) =>
    json.encode(data.toJson());

class PublicProfileResponse {
  PublicProfileResponse({
    this.result,
    this.data,
  });

  bool? result;
  Data? data;

  factory PublicProfileResponse.fromJson(Map<String, dynamic> json) =>
      PublicProfileResponse(
        result: json["result"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
      };
}

class Data {
  Data(
      {this.intoduction,
      this.basicInfo,
      this.presentAddress,
      this.contactDetails,
      this.education,
      this.career,
      this.physicalAttributes,
      this.knownLanguages,
      this.motherTongue,
      this.hobbiesInterest,
      this.attitudeBehavior,
      this.residenceInfo,
      this.spiritualBackgrounds,
      this.lifestyles,
      this.astrologies,
      this.permanentAddress,
      this.familiesInformation,
      this.partnerExpectation,
      this.photoGallery,
      this.profileMatch,
      this.viewContactCheck,
      this.profilePicRequest});

  Intoduction? intoduction;
  BasicInfo? basicInfo;
  var presentAddress;
  ContactDetails? contactDetails;
  List<Education>? education;
  List<Career>? career;
  PhysicalAttributes? physicalAttributes;
  List<MotherTongue>? knownLanguages;
  MotherTongue? motherTongue;
  HobbiesInterest? hobbiesInterest;
  AttitudeBehavior? attitudeBehavior;
  var residenceInfo;
  SpiritualBackgrounds? spiritualBackgrounds;
  Lifestyles? lifestyles;
  Astrologies? astrologies;
  var permanentAddress;
  FamiliesInformation? familiesInformation;
  PartnerExpectation? partnerExpectation;
  List<PhotoGallery>? photoGallery;
  int? profileMatch;
  bool? viewContactCheck;
  bool? profilePicRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        intoduction: json["intoduction"] != null
            ? Intoduction.fromJson(json["intoduction"])
            : json["intoduction"],
        basicInfo: json["basic_info"] != null
            ? BasicInfo.fromJson(json["basic_info"])
            : json["basic_info"],
        presentAddress: json["present_address"] != null
            ? EntAddress.fromJson(json["present_address"])
            : json["present_address"],
        contactDetails: json["contact_details"] != null
            ? ContactDetails.fromJson(json["contact_details"])
            : json["contact_details"],
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        career:
            List<Career>.from(json["career"].map((x) => Career.fromJson(x))),
        physicalAttributes: json["physical_attributes"] != null
            ? PhysicalAttributes.fromJson(json["physical_attributes"])
            : json["physical_attributes"],
        knownLanguages: json["known_languages"] != null
            ? List<MotherTongue>.from(
                json["known_languages"].map((x) => MotherTongue.fromJson(x)))
            : json["known_languages"],
        motherTongue: json["mother_tongue"] != null
            ? MotherTongue.fromJson(json["mother_tongue"])
            : json["mother_tongue"],
        hobbiesInterest: json["hobbies_interest"] != null
            ? HobbiesInterest.fromJson(json["hobbies_interest"])
            : json["hobbies_interest"],
        attitudeBehavior: json["attitude_behavior"] != null
            ? AttitudeBehavior.fromJson(json["attitude_behavior"])
            : json["attitude_behavior"],
        residenceInfo: json["residence_info"] != null
            ? ResidenceInfo.fromJson(json["residence_info"])
            : json["residence_info"],
        spiritualBackgrounds: json["spiritual_backgrounds"] != null
            ? SpiritualBackgrounds.fromJson(json["spiritual_backgrounds"])
            : json["spiritual_backgrounds"],
        lifestyles: json["lifestyles"] != null
            ? Lifestyles.fromJson(json["lifestyles"])
            : json["lifestyles"],
        astrologies: json["astrologies"] != null
            ? Astrologies.fromJson(json["astrologies"])
            : json["astrologies"],
        permanentAddress: json["permanent_address"] != null
            ? EntAddress.fromJson(json["permanent_address"])
            : json["permanent_address"],
        familiesInformation: json["families_information"] != null
            ? FamiliesInformation.fromJson(json["families_information"])
            : json["families_information"],
        partnerExpectation: json["partner_expectation"] != null
            ? PartnerExpectation.fromJson(json["partner_expectation"])
            : json["partner_expectation"],
        photoGallery: List<PhotoGallery>.from(
            json["photo_gallery"].map((x) => PhotoGallery.fromJson(x))),
        profileMatch: json["profile_match"],
        viewContactCheck: json["view_contact_check"],
        profilePicRequest: json["profile_pic_request"],
      );

  Map<String, dynamic> toJson() => {
        "intoduction": intoduction!.toJson(),
        "basic_info": basicInfo!.toJson(),
        "present_address": presentAddress.toJson(),
        "contact_details": contactDetails!.toJson(),
        "education": List<dynamic>.from(education!.map((x) => x.toJson())),
        "career": List<dynamic>.from(career!.map((x) => x.toJson())),
        "physical_attributes": physicalAttributes!.toJson(),
        "known_languages":
            List<dynamic>.from(knownLanguages!.map((x) => x.toJson())),
        "mother_tongue": motherTongue!.toJson(),
        "hobbies_interest": hobbiesInterest!.toJson(),
        "attitude_behavior": attitudeBehavior!.toJson(),
        "residence_info": residenceInfo.toJson(),
        "spiritual_backgrounds": spiritualBackgrounds!.toJson(),
        "lifestyles": lifestyles!.toJson(),
        "astrologies": astrologies!.toJson(),
        "permanent_address": permanentAddress.toJson(),
        "families_information": familiesInformation!.toJson(),
        "partner_expectation": partnerExpectation!.toJson(),
        "photo_gallery":
            List<dynamic>.from(photoGallery!.map((x) => x.toJson())),
        "profile_match": profileMatch,
        "view_contact_check": viewContactCheck,
        "profile_pic_request": profilePicRequest,
      };
}

class Astrologies {
  Astrologies({
    this.sunSign,
    this.moonSign,
    this.timeOfBirth,
    this.cityOfBirth,
  });

  String? sunSign;
  String? moonSign;
  String? timeOfBirth;
  String? cityOfBirth;

  factory Astrologies.fromJson(Map<String, dynamic> json) => Astrologies(
        sunSign: json["sun_sign"],
        moonSign: json["moon_sign"],
        timeOfBirth: json["time_of_birth"],
        cityOfBirth: json["city_of_birth"],
      );

  Map<String, dynamic> toJson() => {
        "sun_sign": sunSign,
        "moon_sign": moonSign,
        "time_of_birth": timeOfBirth,
        "city_of_birth": cityOfBirth,
      };
}

class AttitudeBehavior {
  AttitudeBehavior({
    this.affection,
    this.humor,
    this.politicalViews,
    this.religiousService,
  });

  String? affection;
  String? humor;
  String? politicalViews;
  String? religiousService;

  factory AttitudeBehavior.fromJson(Map<String, dynamic> json) =>
      AttitudeBehavior(
        affection: json["affection"],
        humor: json["humor"],
        politicalViews: json["political_views"],
        religiousService: json["religious_service"],
      );

  Map<String, dynamic> toJson() => {
        "affection": affection,
        "humor": humor,
        "political_views": politicalViews,
        "religious_service": religiousService,
      };
}

class BasicInfo {
  BasicInfo({
    this.firsName,
    this.lastName,
    this.code,
    this.age,
    this.religion,
    this.caste,
    this.dateOfBirth,
    this.onbehalf,
    this.noOfChildren,
    this.gender,
    this.phone,
    this.maritialStatus,
    this.photo,
  });

  String? firsName;
  String? lastName;
  String? code;
  var age;
  String? religion;
  String? caste;
  DateTime? dateOfBirth;
  MotherTongue? onbehalf;
  var noOfChildren;
  String? gender;
  String? phone;
  String? maritialStatus;
  String? photo;

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
        firsName: json["firs_name"],
        lastName: json["last_name"],
        code: json["code"],
        age: json["age"],
        religion: json["religion"],
        caste: json["caste"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        onbehalf: MotherTongue.fromJson(json["onbehalf"]),
        noOfChildren: json["no_of_children"],
        gender: json["gender"],
        phone: json["phone"],
        maritialStatus: json["maritial_status"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "firs_name": firsName,
        "last_name": lastName,
        "code": code,
        "age": age,
        "religion": religion,
        "caste": caste,
        "date_of_birth": dateOfBirth!.toIso8601String(),
        "onbehalf": onbehalf!.toJson(),
        "no_of_children": noOfChildren,
        "gender": gender,
        "phone": phone,
        "maritial_status": maritialStatus,
        "photo": photo,
      };
}

class MotherTongue {
  MotherTongue({
    this.id,
    this.name,
  });

  var id;
  String? name;

  factory MotherTongue.fromJson(Map<String, dynamic> json) => MotherTongue(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Career {
  Career({
    this.id,
    this.designation,
    this.company,
    this.start,
    this.end,
    this.present,
  });

  var id;
  String? designation;
  String? company;
  var start;
  var end;
  bool? present;

  factory Career.fromJson(Map<String, dynamic> json) => Career(
        id: json["id"],
        designation: json["designation"],
        company: json["company"],
        start: json["start"],
        end: json["end"],
        present: json["present"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
        "company": company,
        "start": start,
        "end": end,
        "present": present,
      };
}

class ContactDetails {
  ContactDetails({
    this.email,
    this.phone,
  });

  String? email;
  String? phone;

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
      };
}

class Education {
  Education({
    this.id,
    this.degree,
    this.institution,
    this.start,
    this.end,
    this.present,
  });

  var id;
  String? degree;
  String? institution;
  var start;
  var end;
  bool? present;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        degree: json["degree"],
        institution: json["institution"],
        start: json["start"],
        end: json["end"],
        present: json["present"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "degree": degree,
        "institution": institution,
        "start": start,
        "end": end,
        "present": present,
      };
}

class FamiliesInformation {
  FamiliesInformation({
    this.father,
    this.mother,
    this.sibling,
  });

  String? father;
  String? mother;
  String? sibling;

  factory FamiliesInformation.fromJson(Map<String, dynamic> json) =>
      FamiliesInformation(
        father: json["father"],
        mother: json["mother"],
        sibling: json["sibling"],
      );

  Map<String, dynamic> toJson() => {
        "father": father,
        "mother": mother,
        "sibling": sibling,
      };
}

class HobbiesInterest {
  HobbiesInterest({
    this.hobbies,
    this.interests,
    this.music,
    this.books,
    this.movies,
    this.tvShows,
    this.sports,
    this.fitnessActivities,
    this.cuisines,
    this.dressStyles,
  });

  String? hobbies;
  String? interests;
  String? music;
  String? books;
  String? movies;
  String? tvShows;
  String? sports;
  String? fitnessActivities;
  String? cuisines;
  String? dressStyles;

  factory HobbiesInterest.fromJson(Map<String, dynamic> json) =>
      HobbiesInterest(
        hobbies: json["hobbies"],
        interests: json["interests"],
        music: json["music"],
        books: json["books"],
        movies: json["movies"],
        tvShows: json["tv_shows"],
        sports: json["sports"],
        fitnessActivities: json["fitness_activities"],
        cuisines: json["cuisines"],
        dressStyles: json["dress_styles"],
      );

  Map<String, dynamic> toJson() => {
        "hobbies": hobbies,
        "interests": interests,
        "music": music,
        "books": books,
        "movies": movies,
        "tv_shows": tvShows,
        "sports": sports,
        "fitness_activities": fitnessActivities,
        "cuisines": cuisines,
        "dress_styles": dressStyles,
      };
}

class Intoduction {
  Intoduction({
    this.introduction,
  });

  String? introduction;

  factory Intoduction.fromJson(Map<String, dynamic> json) => Intoduction(
        introduction: json["introduction"],
      );

  Map<String, dynamic> toJson() => {
        "introduction": introduction,
      };
}

class Lifestyles {
  Lifestyles({
    this.diet,
    this.drink,
    this.smoke,
    this.livingWith,
  });

  String? diet;
  String? drink;
  String? smoke;
  String? livingWith;

  factory Lifestyles.fromJson(Map<String, dynamic> json) => Lifestyles(
        diet: json["diet"],
        drink: json["drink"],
        smoke: json["smoke"],
        livingWith: json["living_with"],
      );

  Map<String, dynamic> toJson() => {
        "diet": diet,
        "drink": drink,
        "smoke": smoke,
        "living_with": livingWith,
      };
}

class PartnerExpectation {
  PartnerExpectation({
    this.general,
    this.height,
    this.weight,
    this.maritalStatus,
    this.childrenAcceptable,
    this.residenceCountryId,
    this.religionId,
    this.casteId,
    this.subCasteId,
    this.education,
    this.profession,
    this.smokingAcceptable,
    this.drinkingAcceptable,
    this.diet,
    this.bodyType,
    this.personalValue,
    this.manglik,
    this.language,
    this.familyValueId,
    this.preferredCountryId,
    this.preferredStateId,
    this.complexion,
  });

  String? general;
  var height;
  var weight;
  String? maritalStatus;
  String? childrenAcceptable;
  String? residenceCountryId;
  String? religionId;
  String? casteId;
  String? subCasteId;
  String? education;
  String? profession;
  String? smokingAcceptable;
  String? drinkingAcceptable;
  String? diet;
  String? bodyType;
  String? personalValue;
  String? manglik;
  String? language;
  String? familyValueId;
  String? preferredCountryId;
  String? preferredStateId;
  String? complexion;

  factory PartnerExpectation.fromJson(Map<String, dynamic> json) =>
      PartnerExpectation(
        general: json["general"],
        height: json["height"],
        weight: json["weight"],
        maritalStatus: json["marital_status"],
        childrenAcceptable: json["children_acceptable"],
        residenceCountryId: json["residence_country_id"],
        religionId: json["religion_id"],
        casteId: json["caste_id"],
        subCasteId: json["sub_caste_id"],
        education: json["education"],
        profession: json["profession"],
        smokingAcceptable: json["smoking_acceptable"],
        drinkingAcceptable: json["drinking_acceptable"],
        diet: json["diet"],
        bodyType: json["body_type"],
        personalValue: json["personal_value"],
        manglik: json["manglik"],
        language: json["language"],
        familyValueId: json["family_value_id"],
        preferredCountryId: json["preferred_country_id"],
        preferredStateId: json["preferred_state_id"],
        complexion: json["complexion"],
      );

  Map<String, dynamic> toJson() => {
        "general": general,
        "height": height,
        "weight": weight,
        "marital_status": maritalStatus,
        "children_acceptable": childrenAcceptable,
        "residence_country_id": residenceCountryId,
        "religion_id": religionId,
        "caste_id": casteId,
        "sub_caste_id": subCasteId,
        "education": education,
        "profession": profession,
        "smoking_acceptable": smokingAcceptable,
        "drinking_acceptable": drinkingAcceptable,
        "diet": diet,
        "body_type": bodyType,
        "personal_value": personalValue,
        "manglik": manglik,
        "language": language,
        "family_value_id": familyValueId,
        "preferred_country_id": preferredCountryId,
        "preferred_state_id": preferredStateId,
        "complexion": complexion,
      };
}

class EntAddress {
  EntAddress({
    this.country,
    this.state,
    this.city,
    this.postalCode,
  });

  String? country;
  String? state;
  String? city;
  String? postalCode;

  factory EntAddress.fromJson(Map<String, dynamic> json) => EntAddress(
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
        "postal_code": postalCode,
      };
}

class PhotoGallery {
  PhotoGallery({
    this.imagePath,
  });

  String? imagePath;

  factory PhotoGallery.fromJson(Map<String, dynamic> json) => PhotoGallery(
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "image_path": imagePath,
      };
}

class PhysicalAttributes {
  PhysicalAttributes({
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
    this.complexion,
    this.bloodGroup,
    this.bodyType,
    this.bodyArt,
    this.disability,
  });

  var height;
  var weight;
  String? eyeColor;
  String? hairColor;
  String? complexion;
  String? bloodGroup;
  String? bodyType;
  String? bodyArt;
  String? disability;

  factory PhysicalAttributes.fromJson(Map<String, dynamic> json) =>
      PhysicalAttributes(
        height: json["height"],
        weight: json["weight"],
        eyeColor: json["eye_color"],
        hairColor: json["hair_color"],
        complexion: json["complexion"],
        bloodGroup: json["blood_group"],
        bodyType: json["body_type"],
        bodyArt: json["body_art"],
        disability: json["disability"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "weight": weight,
        "eye_color": eyeColor,
        "hair_color": hairColor,
        "complexion": complexion,
        "blood_group": bloodGroup,
        "body_type": bodyType,
        "body_art": bodyArt,
        "disability": disability,
      };
}

class ResidenceInfo {
  ResidenceInfo({
    this.birthCountry,
    this.recidencyCountry,
    this.growupCountry,
    this.immigrationStatus,
  });

  String? birthCountry;
  String? recidencyCountry;
  String? growupCountry;
  String? immigrationStatus;

  factory ResidenceInfo.fromJson(Map<String, dynamic> json) => ResidenceInfo(
        birthCountry: json["birth_country"],
        recidencyCountry: json["recidency_country"],
        growupCountry: json["growup_country"],
        immigrationStatus: json["immigration_status"],
      );

  Map<String, dynamic> toJson() => {
        "birth_country": birthCountry,
        "recidency_country": recidencyCountry,
        "growup_country": growupCountry,
        "immigration_status": immigrationStatus,
      };
}

class SpiritualBackgrounds {
  SpiritualBackgrounds({
    this.religionId,
    this.casteId,
    this.subCasteId,
    this.ethnicity,
    this.personalValue,
    this.familyValueId,
    this.communityValue,
  });

  String? religionId;
  String? casteId;
  String? subCasteId;
  String? ethnicity;
  String? personalValue;
  String? familyValueId;
  String? communityValue;

  factory SpiritualBackgrounds.fromJson(Map<String, dynamic> json) =>
      SpiritualBackgrounds(
        religionId: json["religion_id"],
        casteId: json["caste_id"],
        subCasteId: json["sub_caste_id"],
        ethnicity: json["ethnicity"],
        personalValue: json["personal_value"],
        familyValueId: json["family_value_id"],
        communityValue: json["community_value"],
      );

  Map<String, dynamic> toJson() => {
        "religion_id": religionId,
        "caste_id": casteId,
        "sub_caste_id": subCasteId,
        "ethnicity": ethnicity,
        "personal_value": personalValue,
        "family_value_id": familyValueId,
        "community_value": communityValue,
      };
}
