import 'package:flutter/material.dart';

class PublicProfileState {
  bool? isFetching;
  BuildContext? loadingContext;
  late BuildContext galleryLoadingContext;
  var intro;
  var basic;
  var presentaddress;
  var permanentaddress;
  var education;
  var career;
  var physical;
  var language;
  var mothertongue;
  var hobbies;
  var attitude;
  var resi;
  var spiritual;
  var lifestyle;
  var astrologies;
  var families;
  var partner;
  bool profilePicRequest=false;
  List? photogallery = [];
  var profilematch;
  var contact;
  String? error;

  var viewContactCheck;

  PublicProfileState.initialState()
      : isFetching = true,
        error = '',
        photogallery = [];

  PublicProfileState({
    this.loadingContext,
    this.isFetching,
    this.intro,
    this.basic,
    this.presentaddress,
    this.permanentaddress,
    this.education,
    this.error,
    this.career,
    this.viewContactCheck,
    this.physical,
    this.language,
    this.mothertongue,
    this.hobbies,
    this.attitude,
    this.resi,
    this.spiritual,
    this.lifestyle,
    this.astrologies,
    this.families,
    this.partner,
    this.photogallery,
    this.profilematch,
   required this.profilePicRequest,
  });
}
