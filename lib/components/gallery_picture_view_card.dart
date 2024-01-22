import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_accept_reject_middleware.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class GalleryPictureViewCard extends StatelessWidget {
  final image;
  final name;
  final age;
  final id;
  final index;
  final status;

  GalleryPictureViewCard(
      {this.image, this.name, this.age, this.id, this.index, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),

      /// box decoration
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [CommonWidget.box_shadow()]),
      // child0

      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 84.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0)),
              child: MyImages.normalImage(image),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${name}',
                          style: Styles.bold_arsenic_14,
                        ),
                        Text(
                          '${age} years',
                          style: Styles.regular_arsenic_14,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        status == 1
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: MyTheme.green,
                                ),
                                child: Text(
                                  'Accepted',
                                  style: Styles.bold_white_10,
                                ),
                              )
                            : Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      store.state.galleryPictureViewState!
                                          .index = index;
                                      profile_picture_accept_reject_show_dialog(
                                          context,
                                          isAcceptOrReject: true,
                                          request_id: id);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(201, 227, 202, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      child: const Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Color.fromRGBO(0, 169, 57, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      profile_picture_accept_reject_show_dialog(
                                        context,
                                        isAcceptOrReject: false,
                                        request_id: id,
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 221, 218, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      child: const Center(
                                        child: Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Color.fromRGBO(255, 75, 62, 1),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> profile_picture_accept_reject_show_dialog(mainContext,
      {bool? isAcceptOrReject, request_id}) {
    return showDialog<void>(
      context: mainContext,
      builder: (BuildContext context) {
        // print("--------------");
        // print("${isAcceptOrReject}");
        // print("--------------");

        return AlertDialog(
          title: Text(
            'Gallery Picture View Request ${isAcceptOrReject! ? "Accept" : "Reject"}',
            style: Styles.bold_arsenic_14,
          ),
          content: Text(
            'Are you sure you want to ${isAcceptOrReject ? "Accept" : "Reject"} this request?',
            style: Styles.regular_arsenic_12,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(255, 221, 218, 1),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: MyTheme.arsenic),
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(201, 227, 202, 1),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: MyTheme.arsenic),
                  )),
              onPressed: () {
                pleaseWaitDialog();
                store.dispatch(getGalleryPictureAcceptRejectMiddleware(
                    id: request_id,
                    isAcceptReject: isAcceptOrReject ? "accept" : "reject"));

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  pleaseWaitDialog() {
    return OneContext().showDialog<void>(
      builder: (BuildContext context) {
        store.state.galleryPictureViewState!.loadingContext = context;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.circularIndicator,
              const Text(
                'Please Wait',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
