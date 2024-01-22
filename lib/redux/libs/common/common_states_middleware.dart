import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/common/country_states_acotions.dart';
import 'package:active_matrimonial_flutter_app/repository/country_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> commonStateCountryMiddleware() {
  return (Store<AppState> store) async {
      var data = await CountryRepository().getCountry();
      store.dispatch(AddCountries(data.data??[]));
  };
}
