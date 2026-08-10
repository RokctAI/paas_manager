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

// Host-owned pages only. Everything that migrated into an SDK is installed
// by the composer under lib/presentation/pages/{orders,create_order,foods,
// restaurant,main,income,order_history,merchant,...} and routed through
// app_router.dart's @generated markers - see composer.json.
export 'initial/splash_page.dart';
export 'initial/no_connection_page.dart';
export 'auth/login/login_page.dart';
export 'view_map/view_map_page.dart';
export 'view_map/map_search_page.dart';
export 'restaurant/notification_list_page.dart';
