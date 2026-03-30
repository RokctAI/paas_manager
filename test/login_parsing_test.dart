import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:venderfoodyman/infrastructure/models/response/login_response.dart';

void main() {
  test('LoginResponse.fromJson should parse the provided JSON', () {
    const jsonString = r'''
{
    "timestamp": "2026-03-30T20:42:27.513106Z",
    "status": true,
    "message": "User successfully login",
    "data": {
        "access_token": "234|eQyDQDeFjlRoam8jmolzRpjWcK4A9E76SvTp54Cp",
        "token_type": "Bearer",
        "user": {
            "id": 114,
            "uuid": "2e36f57d-f67c-4dce-9c3d-e708cfb5d9c1",
            "firstname": "Abala",
            "lastname": "Sarkar",
            "empty_p": false,
            "email": "info.abalasarkar@gmail.com",
            "isWork": 1,
            "phone": "919864340798",
            "gender": "female",
            "active": 1,
            "my_referral": "5VDE3RBG",
            "role": "seller",
            "phone_verified_at": "2025-06-15 17:24:26Z",
            "registered_at": "2025-06-15 17:24:26Z",
            "created_at": "2025-06-15 17:24:26Z",
            "updated_at": "2026-03-30 15:04:37Z",
            "shop": {
                "id": 502,
                "slug": "cakes-502",
                "uuid": "b002217e-37db-4404-8330-77df4b2422b0",
                "user_id": 114,
                "tax": 0,
                "phone": "919464646434",
                "show_type": 1,
                "open": true,
                "visibility": false,
                "verify": 1,
                "new_order_after_payment": false,
                "background_img": "https://api.wrapzo.com/storage/images/shops/114-1750008315.webp",
                "logo_img": "https://api.wrapzo.com/storage/images/shops/114-1750008299.avif",
                "status": "approved",
                "status_note": "Approved",
                "order_payment": "before",
                "avg_rate": 1,
                "delivery_time": {
                    "to": "40",
                    "from": "30",
                    "type": "minute"
                },
                "invite_link": "/shop/invitation/b002217e-37db-4404-8330-77df4b2422b0/link",
                "created_at": "2025-06-15 17:27:39Z",
                "updated_at": "2025-11-25 16:22:32Z",
                "location": {
                    "latitude": "26.1586944",
                    "longitude": "91.7569536"
                },
                "products_count": 0
            },
            "model": null
        }
    }
}
''';
    final jsonResponse = jsonDecode(jsonString);
    final loginResponse = LoginResponse.fromJson(jsonResponse);

    expect(loginResponse.data, isNotNull);
    expect(loginResponse.data!.accessToken, "234|eQyDQDeFjlRoam8jmolzRpjWcK4A9E76SvTp54Cp");
    expect(loginResponse.data!.user, isNotNull);
    expect(loginResponse.data!.user!.id, 114);
    expect(loginResponse.data!.user!.shop, isNotNull);
    expect(loginResponse.data!.user!.shop!.id, 502);
    expect(loginResponse.data!.user!.shop!.location, isNotNull);
    expect(loginResponse.data!.user!.shop!.location!.latitude, 26.1586944);
  });
}
