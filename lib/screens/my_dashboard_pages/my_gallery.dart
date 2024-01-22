import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/gallery_extended_box.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../components/full_screen_image_viewer.dart';
import '../../redux/libs/gallery_image/gallery_image_reducer.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({Key? key}) : super(key: key);

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        if (!store.state.userVerifyState!.isApprove!)
          {
            OneContext().pop(),
            store.dispatch(
              ShowMessageAction(
                msg: "Please verify your account",
                color: MyTheme.failure,
              ),
            ),
          }
        else
          {
            store.dispatch(Reset.myGallery),
            store.dispatch(galleryImageMiddleware()),
          }
      ],
      builder: (_, state) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => store.dispatch(galleryImageMiddleware()),
          child: Column(
            children: [
              buildGradientBoxContainer(context, state),
              Const.height10,
              buildImageGrid(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageGrid(BuildContext context, AppState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              AppLocalizations.of(context)!.gallery_1_screen_featured_photos,
              style: Styles.bold_arsenic_14,
            ),
          ),
          Expanded(
            child: state.galleryImageState!.isFetching!
                ? CommonWidget.circularIndicator
                : Container(
                    child: state.galleryImageState!.galleryImageList!.isNotEmpty
                        ? imageGrid(state)
                        : CommonWidget.noData,
                  ),
          ),
        ],
      ),
    );
  }

  Widget imageGrid(AppState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: MasonryGridView.count(
        padding: EdgeInsets.zero,
        itemCount: state.galleryImageState!.galleryImageList!.length,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImageViewer(state
                      .galleryImageState!.galleryImageList![index].imagePath),
                ),
              );
            },
            child: Stack(
              children: [
                // image
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: Image.network(
                    state.galleryImageState!.galleryImageList![index].imagePath,
                    fit: BoxFit.fill,
                  ),
                ),

                // image delete button
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    color: Colors.black,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      buildDeleteShowDialog(
                          state,
                          state.galleryImageState!.galleryImageList![index]
                              .imageId);
                    },
                    icon: Container(
                      height: 27,
                      width: 27,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        size: 22.0,
                        color: MyTheme.app_accent_color,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> buildDeleteShowDialog(AppState state, id) {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are You Sure That You Want To Delete This Image?',
            style: Styles.bold_arsenic_14,
            textAlign: TextAlign.center,
          ),
          content: Text(
            '**N.B. Deleting An Image Will Not Refund Your Remaining Gallery Capacity**',
            style: Styles.regular_arsenic_12,
            textAlign: TextAlign.center,
          ),
          actions: [
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
                ),
              ),
              onPressed: () {
                OneContext().popDialog();
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
                ),
              ),
              onPressed: () {
                store.dispatch(galleryImageDeleteMiddleware(id: id));
                OneContext().popDialog();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildGradientBoxContainer(BuildContext context, AppState state) {
    return Container(
      height: 200,
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0)),
        gradient: Styles.buildLinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 170,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
            child: Column(
              children: [
                buildImageName(context, state),
                CommonWidget.divider,
                Const.height18,
                Row(
                  children: [
                    Expanded(
                      child: GalleryExtendedBox(
                        text: state
                            .accountState!.profileData!.remainingPhotoGallery
                            .toString(),
                        icon: 'assets/icon/icon_gallery.png',
                      ),
                    ),
                    Const.width10,
                    Expanded(
                      child: GestureDetector(
                        onTap: _addNewImage,
                        child: const GalleryExtendedBox(
                          text: 'Add new image',
                          icon: 'assets/icon/icon_gallery_plus.png',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addNewImage() async {
    print('add new image fnc');
    if (store.state.accountState!.profileData!.currentPackageInfo!
                .packageExpiry !=
            "Expired" &&
        (store.state.accountState!.profileData!.remainingPhotoGallery != 0)) {
      return browseImageDialog();
    } else {
      store.dispatch(ShowMessageAction(msg: 'Please Update Your Package.'));
    }
  }

  browseImageDialog() async {
    print('browse image dialog');
    return OneContext().showDialog(
      builder: (context) => StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.gallery_1_screen_add_new_image,
                  style: Styles.bold_arsenic_14,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => OneContext().popDialog(),
                  icon: Image.asset(
                    'assets/icon/icon_cross.png',
                    height: 16,
                    width: 16,
                  ),
                )
              ],
            ),
            content: TextButton(
              onPressed: () => store.dispatch(getGalleryImageAction(setState)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(MyTheme.solitude),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
              child: SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      store.state.galleryImageState!.imgName ??
                          'Choose file...',
                      style: Styles.regular_gull_grey_12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Browse',
                        style: Styles.regular_storm_grey_12,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  store.dispatch(
                    gallery_image_save(
                        photo: store.state.galleryImageState!.image),
                  );
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: Styles.buildLinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  padding: const EdgeInsets.all(14),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.common_confirm,
                      style: const TextStyle(
                        color: MyTheme.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildImageName(BuildContext context, AppState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/icon/icon_pop_white.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (state.accountState!.profileData?.memberPhoto == null)
              const CircleAvatar(
                  radius: 25,
                  foregroundImage:
                      AssetImage('assets/images/default_avater.png'))
            else
              CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                      state.accountState!.profileData!.memberPhoto!)),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.state.authState?.userData?.name ?? "",
                  style: Styles.bold_white_14,
                ),
                Text(store.state.authState?.userData?.email ?? "",
                    style: Styles.regular_white_12)
              ],
            )
          ],
        ),
      ],
    );
  }
}
