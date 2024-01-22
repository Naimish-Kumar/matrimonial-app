import 'package:active_matrimonial_flutter_app/main.dart';

class PercentageCalculator {
  var data;

  PercentageCalculator({this.data});

  getPercentage() {
    dynamic map = data;

    Map jsonData = map.toJson();
    var percentage;
    var completed;
    Map? finalData;

    jsonData.forEach((key, value) {
      if (value == false) {
        percentage = 0.0;
      } else if (value == true) {
        finalData = data.data.toJson();
        completed = finalData!.length;
        finalData!.forEach((key, value) {
          if (value == null || value == "") {
            completed--;
          }
        });

        percentage = ((completed / finalData!.length) * 100) / 100;

        var twoDecimalValue = percentage.toStringAsFixed(2); // '2.35'
        percentage = double.parse(twoDecimalValue);
      }
    });
    return percentage;
  }

  getBasicPercentage() {
    var percentage;
    var completed;
    Map? jsonData;

    if (data == null) {
      percentage = 0.0;
    } else {
      jsonData = data.toJson();
      jsonData!.forEach((key, value) {
        completed = jsonData!.length;
        jsonData.forEach((key, value) {
          if (value == null || value == "") {
            completed--;
          }
        });
        percentage = ((completed / jsonData.length) * 100) / 100;

        var twoDecimalValue = percentage.toStringAsFixed(2); // '2.35'
        percentage = double.parse(twoDecimalValue);
      });
    }

    return percentage;
  }

  getEducationPercentage() {
    var percentage;

    if (store.state.manageProfileCombineState!.educationState!
            .educationGetResponse!.data!.isEmpty ||
        store.state.manageProfileCombineState!.educationState!
                .educationGetResponse!.data ==
            null) {
      percentage = 0.0;
    } else {
      percentage = (store.state.manageProfileCombineState!.educationState!
                  .educationGetResponse!.data!.length /
              store.state.manageProfileCombineState!.educationState!
                  .educationGetResponse!.data!.length) *
          100 /
          100;
      var twodec = percentage.toStringAsFixed(2);
      percentage = double.parse(twodec);
    }
    return percentage;
  }

  getCareerPercentage() {
    var percentage;

    if (store.state.manageProfileCombineState!.careerState!.careerGetResponse!.data!
            .isEmpty ||
        store.state.manageProfileCombineState!.careerState!.careerGetResponse!
                .data ==
            null) {
      percentage = 0.0;
    } else {
      percentage = (store.state.manageProfileCombineState!.careerState!
                  .careerGetResponse!.data!.length /
              store.state.manageProfileCombineState!.careerState!
                  .careerGetResponse!.data!.length) *
          100 /
          100;
      var twodec = percentage.toStringAsFixed(2);
      percentage = double.parse(twodec);
    }
    return percentage;
  }
}
