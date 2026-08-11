// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

enum OrderStatus { newOrder, accepted, ready, onAWay, delivered, canceled }

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
  users
}

enum DeliveryType { delivery, pickup }

enum ProductStatus { published, pending, unpublished }

enum SignUpType { phone, email, both }

enum WeekDays { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
