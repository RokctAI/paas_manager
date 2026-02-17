enum OrderStatus {
  newOrder,
  cooking,
  accepted,
  ready,
  onAWay,
  delivered,
  canceled,
}

enum SnackBarType { success, info, error }

enum ExtrasType { color, text, image }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
}

enum ProductStatus { published, pending, unpublished }

enum WeekDays { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

enum AiTranslationModel {
  product('Product'),
  category('Category'),
  service('Service'),
  membership('MemberShip'),
  giftCart('GiftCart'),
  formOption('FormOption'),
  shop('Shop'),
  faq('Faq');

  const AiTranslationModel(this.type);

  final String type;
}

enum SignUpType { phone, email, both }
