abstract final class AppRoutes {
  static const catalog = '/catalog';
  static const favorites = '/favorites';
  static const trivia = '/trivia';
  static const settings = '/settings';

  static const detailSegment = 'pokemon/:id';
  static String catalogDetail(int id) => '$catalog/pokemon/$id';
  static String favoriteDetail(int id) => '$favorites/pokemon/$id';
}
