library kitchen_sdk;

// Role folders are siblings of `common/`, per decision_log.md.
//
// `common/` holds what is common *by design*, not by usage count: the
// `KitchensRepositoryFacade` seam a host implements against, the DI entry point
// every generated `main.dart` calls, and the DTOs that seam's signature
// references — a facade in `common/` cannot return a type that lives in a role
// folder without inverting the dependency.
//
// `manager/` holds the concrete implementation and the picker's UI state.
// manager is the only fork landed here so far, and pos may well want the same
// picker verbatim — but "nobody else uses this SDK yet" is not evidence code is
// shared, and no fork session promotes to `common/` from inside its own run.
export 'src/manager/application/kitchens/kitchen_picker_notifier.dart';
export 'src/manager/application/kitchens/kitchen_picker_provider.dart';
export 'src/manager/application/kitchens/kitchen_picker_state.dart';
export 'src/common/di/kitchen_di.dart';
export 'src/common/domain/interface/kitchens.dart';
export 'src/common/infrastructure/models/data/kitchen_data.dart';
export 'src/common/infrastructure/models/response/kitchens_paginate_response.dart';
