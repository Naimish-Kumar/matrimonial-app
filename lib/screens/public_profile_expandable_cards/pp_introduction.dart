import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PP_Information extends StatelessWidget {
  const PP_Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.intro != null
          ? Container(
              child:
                  Text('${state.publicProfileState!.intro.introduction ?? ''}'),
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
            ),
    );
  }
}
