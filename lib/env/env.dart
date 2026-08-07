import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BOOKS_API_KEY', obfuscate: true)
  static final String booksApiKey = _Env.booksApiKey;
}
