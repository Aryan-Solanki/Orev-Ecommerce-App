import 'package:algolia/algolia.dart';

class AlgoliaApplication {
  static final Algolia algolia = Algolia.init(
    applicationId: '3S6309MTOQ', //ApplicationID
    apiKey:
        '322aaf93652221374d5be3bec8b69959', //search-only api key in flutter code
  );
}
