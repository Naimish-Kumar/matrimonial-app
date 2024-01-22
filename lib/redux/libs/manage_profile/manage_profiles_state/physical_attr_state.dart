import 'package:flutter/material.dart';

import '../../../../models_response/manage_profile/get_manage_profile/physical_attributes_get_response.dart';

class PhysicalAttrState {
  bool? isLoading;
  final formKey = GlobalKey<FormState>();

  TextEditingController? heightController = TextEditingController();
  TextEditingController? weightController = TextEditingController();
  TextEditingController? eyeColorController = TextEditingController();
  TextEditingController? hairColorController = TextEditingController();
  TextEditingController? complexionController = TextEditingController();
  TextEditingController? bodyTypeController = TextEditingController();
  TextEditingController? bodyArtController = TextEditingController();
  TextEditingController? disabilityController = TextEditingController();
  TextEditingController? bloodController = TextEditingController();

  PhysicalAttrData? physicalAttrData;

  PhysicalAttrState({
    this.isLoading,
    this.heightController,
    this.weightController,
    this.eyeColorController,
    this.hairColorController,
    this.complexionController,
    this.bodyArtController,
    this.bodyTypeController,
    this.disabilityController,
    this.bloodController,
  });

  PhysicalAttrState.initialState()
      : heightController = TextEditingController(text: ''),
        weightController = TextEditingController(text: ''),
        eyeColorController = TextEditingController(text: ''),
        hairColorController = TextEditingController(text: ''),
        complexionController = TextEditingController(text: ''),
        bodyArtController = TextEditingController(text: ''),
        bodyTypeController = TextEditingController(text: ''),
        disabilityController = TextEditingController(text: ''),
        bloodController = TextEditingController(text: ''),
        physicalAttrData = null,
        isLoading = false;
}
