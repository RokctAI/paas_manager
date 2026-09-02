// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.


class TrKeys {
  TrKeys._();

  // @sdk-tr-keys-start
  static const String reservations = 'reservations';
  static const String myReservations = 'my_reservations';
  static const String newReservation = 'new_reservation';
  static const String reserveATable = 'reserve_a_table';
  static const String chooseAShop = 'choose_a_shop';
  static const String chooseASection = 'choose_a_section';
  static const String chooseATable = 'choose_a_table';
  static const String chooseDateAndTime = 'choose_date_and_time';
  static const String reservationDate = 'reservation_date';
  static const String reservationTime = 'reservation_time';
  static const String reservationGuests = 'reservation_guests';
  static const String reservationSeats = 'reservation_seats';
  static const String reservationNote = 'reservation_note';
  static const String confirmReservation = 'confirm_reservation';
  static const String reservationCreated = 'reservation_created';
  static const String reservationCancelled = 'reservation_cancelled';
  static const String cancelReservation = 'cancel_reservation';
  static const String cancelThisReservation = 'cancel_this_reservation';
  static const String noReservationsYet = 'no_reservations_yet';
  static const String noSectionsYet = 'no_sections_yet';
  static const String noTablesYet = 'no_tables_yet';
  static const String shopNotTakingReservationsYet = 'shop_not_taking_reservations_yet';
  static const String noTimesLeftOnThisDay = 'no_times_left_on_this_day';
  static const String logInToReserveATable = 'log_in_to_reserve_a_table';
  static const String reservationStatusNew = 'reservation_status_new';
  static const String reservationStatusAccepted = 'reservation_status_accepted';
  static const String reservationStatusCancelled = 'reservation_status_cancelled';
  static const String tables = 'tables';
  static const String tablesAndSections = 'tables_and_sections';
  static const String reservationSchedule = 'reservation_schedule';
  static const String bookingHours = 'booking_hours';
  static const String bookingWorkingDays = 'booking_working_days';
  static const String bookingClosedDates = 'booking_closed_dates';
  static const String addSection = 'add_section';
  static const String addTable = 'add_table';
  static const String sectionName = 'section_name';
  static const String tableName = 'table_name';
  static const String chairCount = 'chair_count';
  static const String markAccepted = 'mark_accepted';
  static const String markNew = 'mark_new';
  static const String markCancelled = 'mark_cancelled';
  static const String addBookingHours = 'add_booking_hours';
  static const String opensAt = 'opens_at';
  static const String closesAt = 'closes_at';
  static const String maxMinutesPerReservation = 'max_minutes_per_reservation';
  static const String saveSchedule = 'save_schedule';
  static const String scheduleSaved = 'schedule_saved';
  static const String addClosedDate = 'add_closed_date';
  static const String deleteThisSectionAndItsTables = 'delete_this_section_and_its_tables';
  static const String deleteThisTable = 'delete_this_table';
  static const String noShopOnThisAccount = 'no_shop_on_this_account';
  static const String reservedFor = 'reserved_for';
  static const String reservationsAreNotAvailable = 'reservations_are_not_available';
  static const String calculator = 'calculator';
  static const String tape = 'tape';
  static const String clearTheTape = 'clear_the_tape';
  static const String tapeKeepsLast10 = 'the_tape_keeps_the_last_10_calculations';
  static const String useAsTheAmount = 'use_{amount}_as_the_amount';
  static const String fillsTheAmountNeverTheCart = 'fills_the_amount_display_it_never_touches_the_cart';
  static const String unread = 'unread';
  static const String kitchen = 'kitchen';
  static const String kitchens = 'kitchens';
  static const String live = 'live';
  static const String justIn = 'just_in';
  static const String delayed = 'delayed';
  static const String preparing = 'preparing';
  static const String dish = 'dish';
  static const String dishes = 'dishes';
  static const String customerNote = 'customer_note';
  static const String markOrderReady = 'mark_order_ready';
  static const String startCooking = 'start_cooking';
  static const String handOver = 'hand_over';
  static const String tapDishHint = 'tap_a_dish_to_advance_double_tap_cancels';
  static const String scan = 'Scan';
  static const String addItems = 'Add Items';
  static const String items = 'Items';
  static const String editQuantity = 'Edit quantity';
  static const String qrPayLink = 'QR / Pay link';
  static const String letCustomerScanQr = 'Let the customer scan this QR to pay online.';
  static const String iveScannedWaitForCode = 'I\'ve Scanned, Wait for Code';
  static const String printReceipt = 'Print Receipt & Finish';
  static const String finish = 'Finish without Receipt';
  static const String activeTransaction = 'Active Transaction';
  static const String tillOfflineBanner = 'Till offline — payment confirms by code. The customer pays the link on their phone and reads you the 6-digit code from their payment screen; the sale syncs when you are back online.';
  static const String confirmByCode = 'Confirm by Code';
  static const String enterSixDigitCode = 'Enter the 6-digit verification code shown on the customer\'s payment screen after successful payment.';
  static const String sixDigitCode = '6-Digit Code';
  static const String paymentConfirmed = 'Payment confirmed';
  static const String invalidCode = 'That code doesn\'t match. Check it with the customer and try again.';
  static const String printFailed = 'Printing failed — the sale was NOT recorded. Fix the printer or finish without a receipt.';
  static const String saleCompleted = 'Sale completed';
  static const String inStore = 'In-store';
  static const String sendForDelivery = 'Send for delivery';
  static const String billingTo = 'Billing to';
  static const String addCustomer = 'Add customer';
  static const String changeCustomer = 'Change';
  static const String owes = 'owes';
  static const String searchCustomers = 'Search customers';
  static const String amountPayingNow = 'Amount paying now';
  static const String payingOf = 'of';
  static const String fullAmount = 'Full';
  static const String allOnCredit = '— all on credit';
  static const String creditRemainder = 'remains — the sale completes as a CREDIT order on the customer\'s account and auto-collects in full from their next wallet top-up (oldest debt first).';
  static const String creditAvailableFronts = 'Credit available — shop fronts the';
  static const String commissionAllowanceCovers = 'commission; allowance covers it.';
  static const String creditUnavailable = 'Credit unavailable — completing on credit would breach the shop\'s credit allowance.';
  static const String deliversTo = 'Delivers to';
  static const String deliveryFeeJoins = 'delivery fee joins the order';
  static const String addDeliveryAddress = 'Add the delivery address';
  static const String deliveryNeedsAddress = 'Add a delivery address to send this order out.';
  static const String deliveryNeedsCustomer = 'Attach a customer to send this order for delivery.';
  static const String sendForDeliveryFinish = 'Send for delivery & Finish';
  static const String entersOrderQueue = 'enters the order queue · mark Ready when packed';
  static const String takes = 'takes';
  static const String nowWord = 'now';
  static const String records = 'records';
  static const String due = 'due';
  static const String payingNow = 'Paying now';
  static const String onCredit = 'On credit';
  static const String pendingSync = 'pending sync';
  static const String theRestaurantIsClosedToday = 'the_restaurant_is_closed_today';
  static const String before = 'before';
  static const String after = 'after';
  static const String orderPayment = 'order.payment';
  static const String setUpYourShop = 'set_up_your_shop';
  static const String shopSetupExplainer = 'a_few_details_to_open_your_shop_you_can_change_everything_later';
  static const String shopName = 'shop_name';
  static const String accessDenied = 'access.denied';
  static const String syncIssues = 'sync_issues';
  static const String discard = 'discard';
  static const String parked = 'parked';
  static const String needsAttention = 'needs_attention';
  static const String productivity = 'Productivity';
  static const String tasks = 'Tasks';
  static const String quickFlow = 'Quick flow';
  static const String quickFlowExplainer = 'Let the till run itself between customers — every switch here is per-shop';
  static const String autoAcceptOrders = 'Auto-accept incoming orders';
  static const String autoAcceptOrdersExplainer = 'New orders land as Accepted instead of waiting for a tap on the board';
  static const String liveServer = 'LIVE · SERVER';
  static const String autoAcceptPlatformGate = 'Also needs the platform switch Auto Approve All Orders — with both on, checkout writes the order straight to Accepted';
  static const String autoCompleteAtReady = 'Auto-complete at Ready';
  static const String autoCompleteAtReadyExplainer = 'The moment an order is marked Ready it completes itself';
  static const String autoCompleteAtReadyWarning = 'Orders complete without anyone handing them over — nobody taps to confirm the customer took it, so only turn this on where the customer is already standing at the counter, and only pickup orders are completed';
  static const String newFlag = 'NEW';
  static const String keypadAutodial = 'Keypad autodial';
  static const String keypadAutodialExplainer = 'With nothing on the ticket, a digit key adds its preset item — cash-register style';
  static const String digitPresets = 'Digit presets';
  static const String ofNineSet = 'of 9 set';
  static const String addItem = 'Add item';
  static const String chooseItemForKey = 'Choose an item for key';
  static const String quickFlowAllThreeOn = 'A shop with all three on';
  static const String whatTheAttendantDoes = 'what the attendant actually does';
  static const String quickFlowStep1Title = 'Money in';
  static const String quickFlowStep1Body = 'The customer pays, and a digit key puts the item on the ticket — no menu hunting';
  static const String quickFlowStep2Title = 'Order auto-flows';
  static const String quickFlowStep2Body = 'It is born Accepted — never sits in the New column waiting for a tap';
  static const String quickFlowStep3Title = 'No per-order taps';
  static const String quickFlowStep3Body = 'Ready completes itself — staff serve the customer while the board clears behind them';
  static const String autodialArmedHint = 'Autodial is on — tap a digit to drop its preset straight on the ticket, and once an item is on the keys are money again';
  static const String keysAreMoneyAgain = 'Ticket has an item — the keys are money again';
  static const String aDriverWasAlreadyOnThisOneSoThe = 'a_driver_was_already_on_this_one_so_the';
  static const String assignedToDriver = 'assigned';
  static const String collectedInPerson = 'collected_in_person';
  static const String conversionQueuedForSync = 'conversion_queued_for_sync';
  static const String customerIsHereConvertToPickup = 'customer_is_here_convert_to_pickup';
  static const String deliveryFeeGoesBackToTheCustomersWallet = 'delivery_fee_goes_back_to_the_customers_wallet';
  static const String deliveryTypeRow = 'delivery_type';
  static const String driverTask = 'driver_task';
  static const String feeComesBackIfNoDriverWasOnItYet = 'fee_comes_back_if_no_driver_was_on_it_yet';
  static const String feeIsKept = 'fee_is_kept';
  static const String feeKeptCoversTheDriversCallout = 'fee_kept_covers_the_drivers_callout';
  static const String feeRefundedToWallet = 'fee_refunded_to_wallet';
  static const String goods = 'goods';
  static const String handOverAndConvert = 'hand_over_and_convert';
  static const String handOverAndConvertToPickup = 'hand_over_and_convert_to_pickup';
  static const String handOverNowConvertWhenBackOnline = 'hand_over_now_convert_when_back_online';
  static const String handedToTheCustomerNow = 'handed_to_the_customer_now';
  static const String isUnassignedAndHisTaskCancels = 'is_unassigned_and_his_task_cancels_in_the_driver_app';
  static const String itCoversTheCalloutAndHisTaskCancels = 'it_covers_the_callout_and_his_task_cancels';
  static const String itCoversTheDriversCallout = 'it_covers_the_drivers_callout_he_already_drove_for_it';
  static const String keptNotRefunded = 'kept_not_refunded';
  static const String neverWithheldNeverForfeited = 'never_withheld_never_forfeited_whatever_else_happens_here';
  static const String noDriverAssignedYet = 'no_driver_assigned_yet';
  static const String noDriverWasEverOnIt = 'no_driver_was_ever_on_it';
  static const String noDriverWasOnItYetSoThe = 'no_driver_was_on_it_yet_so_the';
  static const String nobodyDispatched = 'nobody_has_been_dispatched_for_this_order';
  static const String nobodyToStandDown = 'nobody_to_stand_down';
  static const String offlineHandOverNote = 'the_customer_gets_the_order_now_either_way_the_driver_check_and_the_wallet_credit_live_on_the_server';
  static const String onACallout = 'on_a_callout';
  static const String onThisOrder = 'on_this_order';
  static const String pickedUp = 'picked_up';
  static const String refundedToTheCustomersWallet = 'refunded_to_the_customers_wallet';
  static const String theMomentYouConvert = 'the_moment_you_convert';
  static const String thisOneHadADriverOnItSoItDoesNot = 'this_one_had_a_driver_on_it_so_it_does_not';
  static const String accepted = 'accepted';
  static const String addUser = 'add.user';
  static const String approximateTime = 'spproximate_preparation_time: ';
  static const String canceled = 'canceled';
  static const String cooking = 'cooking';
  static const String dropHere = 'drop_here';
  static const String pickupSkipsOnAWay = 'pickup_skips_on_a_way';
  static const String ready = 'ready';
  static const String onAWay = 'on_a_way';
  static const String startEnd = 'start_end';
  static const String reprintReceipt = 'reprint_receipt';
  static const String receiptReprinted = 'receipt_reprinted';
  static const String receiptReprintFailed = 'receipt_reprint_failed';
  static const String viewMore = 'view_more';
  static const String clearAllOrders = 'clear_all_orders';
  static const String delivered = 'delivered';
  static const String customerInformation = 'customer.information';
  static const String deliveryService = 'delivery_service';
  static const String deliveryType = 'delivery.type';
  static const String dineIn = 'dine_in';
  static const String entrance = 'entrance';
  static const String estimatedTime = 'estimated_delivery_time:';
  static const String failed = 'failed';
  static const String noName = 'no_name';
  static const String noOrders = 'no_orders';
  static const String noTransaction = 'no_transaction';
  static const String onAWayOrders = 'on_a_way_orders';
  static const String otpCode = 'otp.code';
  static const String outOfStock = 'out_of_stock';
  static const String payment = 'payment';
  static const String pending = 'pending';
  static const String pleaseSelectASection = 'please_select_a_section';
  static const String pleaseSelectATable = 'please_select_a_table';
  static const String pleaseSelectAUser = 'please_select_a_user';
  static const String priceInformation = 'price.information';
  static const String published = 'published';
  static const String readyOrders = 'ready_orders';
  static const String searchLocation = 'search_location';
  static const String selectTable = 'select.table';
  static const String selectedAddress = 'selected_address';
  static const String selectedSection = 'selected.section';
  static const String selectedTable = 'selected.table';
  static const String selectedTimeAndDay = 'selected_time_and_day';
  static const String selectedUser = 'selected_user';
  static const String shippingAddress = 'shipping_address';
  static const String swipeToAccept = 'swipe_to_accept';
  static const String swipeToDelivered = 'swipe_to_delivered';
  static const String swipeToReady = 'swipe_to_ready';
  static const String swipeToWay = 'swipe_to_way';
  static const String table = 'table';
  static const String takeAway = 'take_away';
  static const String thereAre = 'there_are';
  static const String addNewCategory = 'add_new_category';
  static const String addVariant = 'add_variant';
  static const String belowTheLowStockLine = 'below_the_low_stock_line';
  static const String changes = 'changes';
  static const String cost = 'cost';
  static const String costNotSet = 'cost_not_set';
  static const String costPriceHelper = 'feeds_profit_on_every_sale_set_it_to_see_margins';
  static const String countsOnly = 'counts_only';
  static const String details = 'details';
  static const String extrasGroupsHint = 'extras_groups_make_one_stock_row_per_combination';
  static const String inStock = 'in_stock';
  static const String inactive = 'inactive';
  static const String leftWord = 'left';
  static const String lowStock = 'low_stock';
  static const String lowWord = 'low';
  static const String margin = 'margin';
  static const String newProduct = 'new_product';
  static const String noProducts = 'no_products';
  static const String nothingToCountHere = 'nothing_to_count_here';
  static const String outWord = 'out';
  static const String quickStockHint = 'tap_to_adjust_counts_prices_and_variants_stay_in_the_product_form';
  static const String quickStockUpdate = 'quick_stock_update';
  static const String saveDetails = 'save_details';
  static const String saveStocks = 'save_stocks';
  static const String stockWord = 'stock';
  static const String variants = 'variants';
  static const String addNewExtras = 'add_new_extras';
  static const String addNewExtrasGroup = 'add_new_extras_group';
  static const String addProduct = 'add_product';
  static const String addons = 'addons';
  static const String adultsOnly = 'adults_only_18_plus';
  static const String areYouSureToDelete = 'are_you_sure_to_delete';
  static const String categoryName = 'category_name';
  static const String costPrice = 'cost_price';
  static const String edit = 'edit';
  static const String extras = 'extras';
  static const String input = 'input';
  static const String interval = 'interval';
  static const String maxQtyShouldBeGreaterThanMinQty = 'max_qty_should_be_greater_than_min_qty';
  static const String maxQuantity = 'max_quantity';
  static const String minQuantity = 'min_quantity';
  static const String minQuantityError = 'min_quantity_error';
  static const String productCategory = 'product_category';
  static const String productTitle = 'product.title';
  static const String quantity = 'quantity';
  static const String showProduct = 'show_the_product_to_the_customer';
  static const String sku = 'sku';
  static const String stocks = 'stocks';
  static const String subShopCategory = 'sub.shop.category';
  static const String successfullyCreated = 'successfully_created';
  static const String successfullyUpdated = 'successfully_updated';
  static const String thanksForCategory = 'thanks.for.category';
  static const String units = 'units';
  static const String updateFailed = 'update_failed';
  static const String moreAboutOrders = 'more_about_orders';
  static const String revenue = 'revenue';
  static const String profit = 'profit';
  static const String avgOrder = 'avg_order';
  static const String asSold = 'as_sold';
  static const String ofWord = 'of';
  static const String ordersCosted = 'orders_costed';
  static const String ofCostedRevenue = 'of_costed_revenue';
  static const String vsPreviousPeriod = 'vs_previous_period';
  static const String payout = 'payout';
  static const String grossRevenue = 'gross_revenue';
  static const String platformFee = 'platform_fee';
  static const String yourPayout = 'your_payout';
  static const String revenueVsProfit = 'revenue_vs_profit';
  static const String ordersByStatus = 'orders_by_status';
  static const String totalWord = 'total';
  static const String moreWord = 'more';
  static const String profitByProduct = 'profit_by_product';
  static const String thisPeriod = 'this_period';
  static const String thisWeek = 'this_week';
  static const String thisMonth = 'this_month';
  static const String customRange = 'custom_range';
  static const String week = 'week';
  static const String soldWord = 'sold';
  static const String byVariant = 'by_variant';
  static const String standardWord = 'standard';
  static const String editCostPrice = 'edit_cost_price';
  static const String setCosts = 'set_costs';
  static const String ordersExcludedFromProfit = 'orders_excluded_from_profit';
  static const String noCostRecordedAtSale = 'no_cost_recorded_at_sale';
  static const String unknownCostRevenueExplainer = 'of_revenue_sold_without_a_cost_price_it_is_left_out_of_profit_and_margin_never_counted_as_pure_profit';
  static const String costFrozenAtSaleNote = 'as_sold_profit_uses_the_cost_frozen_on_each_order_line_at_sale_changing_cost_later_never_rewrites_old_orders';
  static const String profitabilityCouldNotBeLoaded = 'profitability_could_not_be_loaded';
  static const String retry = 'retry';
  static const String asOf = 'as.of';
  static const String drawing = 'drawing';
  static const String points = 'points';
  static const String pointsPlaced = 'points.placed';
  static const String shapeNotClosedYet = 'shape.not.closed.yet';
  static const String km2 = 'km2';
  static const String covered = 'covered';
  static const String whereThisShopDelivers = 'where.this.shop.delivers';
  static const String tapMapNewPointsExtendShape = 'tap.the.map.to.add.a.point.new.points.extend.the.shape';
  static const String tapMapSaveUnlocksAt4 = 'tap.the.map.to.add.a.point.save.unlocks.at.4';
  static const String undoLastPoint = 'undo.last.point';
  static const String saveDeliveryZone = 'save.delivery.zone';
  static const String oneMorePointToCloseTheShape = '1.more.point.to.close.the.shape';
  static const String twoMorePointsToCloseTheShape = '2.more.points.to.close.the.shape';
  static const String threeMorePointsToCloseTheShape = '3.more.points.to.close.the.shape';
  // @sdk-tr-keys-end

  static const String bgPicture = 'bg_picture';
  static const String documents = 'documents';
  static const String uploadDocuments = 'upload.documents';
  static const String helpInfo = 'help.info';
  static const String uiType = 'ui_type';
  static const String orderImage = 'order.image';
  static const String especiallyForYou = 'especially_for_you';
  static const String workForYou = 'work_for_you';
  static const String readAll = 'read_all';
  static const String to = 'to';
  static const String created = 'created';
  static const String offers = 'offers';
  static const String notValidDate = 'not.valid.date';
  static const String searchTheMenu = 'search.the.menu';
  static const String tapAnywhereToFlipBack = 'tap_anywhere_to_flip_back';
  static const String tellThisCodeToDriver = 'tell.this.code.to.driver';
  static const String thisImageWasUploadDriver =
      'this.image.was.uploaded.by.driver';
  static const String price = 'price';
  static const String customTip = 'custom.tip';
  static const String tips = 'would.you.like.to.add.a.tip?';
  static const String deliveryTip = 'delivery.tip';
  static const String parcels = 'parcels';
  static const String home = 'home';
  static const String privacy = 'privacy';
  static const String reservation = 'reservation';
  static const String best = 'best';
  static const String game = 'game';
  static const String custom = 'custom';
  static const String wantToPlayGame = 'want.to.play.game';
  static const String youWin = 'you.win';
  static const String newGame = 'new.game';
  static const String gameOver = 'game.over';
  static const String score = 'score';
  static const String tryAgain = 'try.again';
  static const String thisFieldIsRequired = 'this.field.is.required';
  static const String ifYouWantToUseThisService =
      'if.you.want.to.use.this.service';
  static const String receiver = 'receiver';
  static const String selectPaymentMethod = 'select.payment.method';
  static const String youWritePhoneAndFirstname =
      'you.need.write.phone.and.firstname.for.someone';
  static const String sm = 'sm';
  static const String yourOrderDidNotReachMinAmountMinAmountIs =
      'your.order.did.not.reach.min.amount.min.amount.is';
  static const String unpaid = 'unpaid';
  static const String payLater = 'pay.later';
  static const String pay = 'pay';
  static const String iWantToOrderForSomeone = 'I.want.to.order.for.someone';
  static const String expensive = 'expensive';
  static const String leastExpensive = 'least_expensive';
  static const String standard = 'standard';
  static const String gotIt = 'got_it';
  static const String addAddress = 'add_address';
  static const String selectAddress = 'select_address';
  static const String type = 'type';
  static const String parcelDetail = 'parcel_details';
  static const String activeParcel = 'active_parcel';
  static const String parcelHistory = 'parcel_history';
  static const String itemValue = 'item_value';
  static const String remainAnonymous = 'remain_anonymous';
  static const String dontNotifyRecipient = 'dont_notify_a_recipient';
  static const String recipient = 'recipient';
  static const String sender = 'sender';
  static const String explore = 'explore';
  static const String addInstruction = 'add_instruction';
  static const String newItem = 'new.items.with.a.discount';
  static const String whatAreYouSending = 'what_are_you_sending';
  static const String itemDescription = 'item_description';
  static const String chooseBrand = 'choose_brand';
  static const String needSelectProduct = 'need_select_product';
  static const String imageGenerateTake = 'image_generate_take';
  static const String generateImageWithChatGPT = 'generate_image_with_chatGPT';
  static const String gallery = 'gallery';
  static const String set = 'set_up_delivery';
  static const String fast = 'fast_secure_delivery';
  static const String deliveryRestriction = 'delivery_restriction';
  static const String saveTime = 'save_time';
  static const String back = 'back';
  static const String kg = 'kg';
  static const String upTo = 'up.to';
  static const String howItWorks = 'how_it_works';
  static const String errorWithConnectingToFirebase =
      'error_with_connecting_to_firebase';
  static const String doYouLeaveGroup = 'do_you_leave_group';
  static const String chatWithAdmin = 'chat_with_admin';
  static const String select = 'select';
  static const String deliveryTo = 'delivery.to';
  static const String cart = 'cart';
  static const String learnMore = 'learn.more';
  static const String yourPersonalDoor = 'your.personal.door';
  static const String doorToDoor = 'door_to_door';
  static const String stories = 'stories';
  static const String favouriteBrand = 'favourite.brands';
  static const String popularNearYou = 'popular.near.you';
  static const String fosend = 'fosend';
  static const String recently = 'recently';
  static const String thankYouForOrder = 'thank_you_for_order';
  static const String typeSomething = 'type_something';
  static const String groupOrder = 'group_order';
  static const String allServices = 'all_services';
  static const String isEditOrder = 'is_edit_order';
  static const String leaveGroup = 'leave_group';
  static const String joinOrder = 'join_order';
  static const String join = 'join';
  static const String youCanOnly = 'you_can_only';
  static const String branches = 'branches';
  static const String notWork = "not_work";
  static const String emailOrPhoneNumber = "email_or_phone_number";
  static const String timeSchedule = "time_schedule";
  static const String moreInfo = 'more_info';
  static const String canNotBeEmpty = 'can_not_be_empty';
  static const String coped = 'copied';
  static const String referralFaq = 'referral_faq';
  static const String ratings = 'ratings';
  static const String yourOrderStatusChanged =
      'your_order_status_has_been_changed';
  static const String openShop = 'open_shop';
  static const String deals = 'deals';
  static const String maxQty = 'max_qty';
  static const String openUntil = 'open_until';
  static const String notEnoughMoney = 'not_enough_money';
  static const String signUpToDeliver = 'sign_up_to_deliver';
  static const String open = 'open';
  static const String close = 'close';
  static const String terms = 'terms';
  static const String privacyPolicy = 'privacy_policy';
  static const String about = 'about';
  static const String careers = 'careers';
  static const String balance = 'balance';
  static const String share = 'share';
  static const String copyCode = 'copy_code';
  static const String inviteFriend = 'invite_friend';
  static const String referralIncorrect = 'referral_incorrect';
  static const String referral = 'referral';
  static const String goToAdminPanel = 'go_to_admin_panel';
  static const String emailAlreadyExists = 'email_already_exists';
  static const String yourRequest = 'your_request_is_being_processed';
  static const String deliveryTimeFrom = 'delivery_time_from';
  static const String deliveryTimeTo = 'delivery_time_to';
  static const String startPrice = 'start_price';
  static const String pricePerKm = 'price_per_km';
  static const String deliveryTimeType = 'delivery_time_type';
  static const String recommendedSize = "recommended_size";
  static const String productPicture = 'product_picture';
  static const String restaurant = 'restaurant';
  static const String description = 'description';
  static const String restaurantName = 'restaurant_name';
  static const String noDriverZone = "no_driver_zone";
  static const String minQty = 'min_qty';
  static const String deposit = 'deposit_withdrawl';
  static const String paymentDate = 'payment_date';
  static const String transactions = 'transactions';
  static const String done = 'done';
  static const String owner = 'owner';
  static const String started = 'started';
  static const String groupOrderProgress = 'group_order_progress';
  static const String deleteUser = 'delete_user';
  static const String ingredients = 'ingredients';
  static const String choosing = 'choosing';
  static const String youFullyManaga = 'you_fully_manage';
  static const String addAddressInformation = 'add_address_information';
  static const String wallet = 'wallet';
  static const String repeatOrder = 'repeat_order';
  static const String autoOrder = 'auto_order';
  static const String removeAutoOrder = 'remove_auto_order';
  static const String autoOrderInfo = 'auto_order_info';
  static const String autoOrderCreatedSuccessfully =
      'auto_order_created_successfully';
  static const String autoOrderDeletedSuccessfully =
      'auto_order_deleted_successfully';
  static const String paymentMethodFailed = 'payment_method_failed';
  static const String typeHere = 'type_here';
  static const String notification = 'notification';
  static const String lowRating = 'low_rating';
  static const String lowSale = 'low_sale';
  static const String highlyRated = 'highly_rated';
  static const String bestSale = 'best_sale';
  static const String trustYou = 'trust_you';
  static const String deleteAccount = 'delete_account';
  static const String areYouSure = 'are_you_sure';
  static const String answer = 'answer';
  static const String cause = 'cause';
  static const String successfully = 'successfully';
  static const String whyDoYouWant = 'why_do_you_want';
  static const String wantIt = 'want_it';
  static const String count = 'count';
  static const String giftBuy = 'gift_buy';
  static const String paymentTypeIsNotAdded = 'payment_type_is_not_added';
  static const String youCantCreateOrder = 'you_cant_create_order';
  static const String noPaymentType = 'no_payment_type';
  static const String loading = 'loading';
  static const String reFound = 'refound';
  static const String thisTimeIsNotAvailable = "this_time_is_not_available";
  static const String freeDelivery = 'free_delivery';
  static const String sortBy = 'sort_by';
  static const String specialOffers = 'special_offers';
  static const String rating = 'rating';
  static const String priceRange = 'price_range';
  static const String from = 'from';
  static const String shopAndRestaurants = 'shop_and_restaurants';
  static const String show = "show";
  static const String under = "under";
  static const String noDriver = "no_driver";
  static const String driver = "driver";
  static const String id = "id";
  static const String youHavePromoCode = "you_have_promo_code";
  static const String notWorkTodayTime = "not_work_today_time";
  static const String notWorkTomorrow = "not_work_tomorrow";
  static const String notWorkToday = "not_work_today";
  static const String notWorkTodayAndTomorrow = "not_work_today_and_tomorrow";
  static const String bonus = "bonus";
  static const String shopBonus = "shop.bonus";
  static const String totalDiscount = 'total_discount';
  static const String shopTax = 'shop_tax';
  static const String totalTax = 'total_tax';
  static const String subtotal = 'subtotal';
  static const String min = "min";
  static const String other = "other";
  static const String tomorrow = "tomorrow";
  static const String activeOrders = "active_orders";
  static const String cash = "cash";
  static const String today = "today";
  static const String timeDelivery = "time_delivery";
  static const String callToSupport = 'call_to_support';
  static const String stillHaveQuestions = 'still_have_questions';
  static const String cantFindTheAnswer = 'cant_find_the_answer';
  static const String cartIsEmpty = 'cart_is_empty';
  static const String allPreviouslyAdded = "all_previously_added";
  static const String agreeLocation = 'agree_location';
  static const String nothingFound = 'nothing_found';
  static const String trySearchingAgain = "try_searching_again";
  static const String orderNow = 'order_now';
  static const String results = 'results';
  static const String found = 'found';
  static const String restaurants = 'restaurants';
  static const String noRestaurant = 'no_restaurant';
  static const String ratingCourier = 'rating_courier';
  static const String sendMessage = 'send_message';
  static const String callTheDriver = 'call_the_driver';
  static const String callCenterRestaurant = 'call_center_restaurant';
  static const String compositionOrder = 'composition_order';
  static const String promoCode = 'promo_code';
  static const String addPromoCode = 'add_promocode';
  static const String paymentMethods = 'payment_methods';
  static const String continueToPayment = 'continue_to_payment';
  static const String yourOrder = 'your_orders';
  static const String comment = 'comment';
  static const String floor = 'floor';
  static const String house = 'house';
  static const String office = 'office';
  static const String clearCard1 = 'your_card_below';
  static const String clearCard2 = 'do_you_want_to_delete_it?';
  static const String cvc = 'CVC';
  static const String expiredDate = 'expired_date';
  static const String fullName = 'full_name';
  static const String cardNumber = 'card_number';
  static const String addNewCart = 'add_new_card';
  static const String likeRestaurants = 'liked_restaurant';
  static const String add = 'add';
  static const String groupMember = 'group_member';
  static const String manageOrder = 'manage_order';
  static const String start = 'start';
  static const String startGroupOrder = 'start_group_order';
  static const String clear = 'clear';
  static const String clearCard = 'you_really_want_to_clear_the_card';
  static const String serviceFee = 'service_fee';
  static const String deliveryPrice = 'delivery_price';
  static const String total = 'total';
  static const String mobileNumber = 'mobile_number';
  static const String alternativeNumber = 'alternative_number';
  static const String help = 'help';
  static const String setting = 'settings';
  static const String allRestaurants = 'popular.near.you';
  static const String newsOfWeek = 'news_of_the_week';
  static const String popular = 'popular';
  static const String recommended = 'recommended';
  static const String send = 'send';
  static const String resetPasswordText = "reset_password_text";
  static const String resendOtp = 'send_new';
  static const String sendOtp = 'we_are_send_OTP_code_to';
  static const String enterOtp = 'enter_OTP_code';
  static const String county = 'country';
  static const String orAccessQuickly = 'or_access_quickly';
  static const String keepLogged = 'keep_me_logged_in';
  static const String shopList = 'shop_list';
  static const String viewMap = 'view_map';
  static const String address = 'address';
  static const String personalInformation = 'personal_information';
  static const String savedStores = 'saved_stores';
  static const String discount = 'discount';
  static const String viewedProducts = 'viewed_products';
  static const String walletHistory = 'wallet_history';
  static const String blogs = 'blogs';
  static const String savedLocations = 'saved_locations';
  static const String orderHistory = 'order_history';
  static const String chat = 'chat';
  static const String becomeSeller = 'become_seller';
  static const String logout = 'logout';
  static const String noWallet = 'no_wallet';
  static const String systemSettings = 'system_settings';
  static const String selectLanguage = 'select_language';
  static const String next = 'next';
  static const String skip = 'skip';
  static const String login = 'login';
  static const String email = 'email';
  static const String password = 'password';
  static const String forgotPassword = 'forgot_password';
  static const String continueWithGoogle = 'continue_with_google';
  static const String dontHaveAnAcc = 'dont_have_an_account';
  static const String register = 'register';
  static const String enterADeliveryAddress = 'enter_a_delivery_address';
  static const String confirmLocation = 'confirm_location';
  static const String title = 'title';
  static const String save = 'save';
  static const String searchProducts = 'search_restaurant_and_products';
  static const String all = 'all';
  static const String openNow = 'open_now';
  static const String newKey = 'new';
  static const String allShops = 'all_shops';
  static const String work247 = 'work_247';
  static const String pickup = 'pickup';
  // ignore: constant_identifier_names
  static const String pickup_point = 'pickup_point';
  static const String pickupAt = 'pickup_at';
  static const String language = 'languages';
  static const String currency = 'currency';
  static const String theme = 'theme';
  static const String notifications = 'notifications';
  static const String filter = 'filter';
  static const String clearAll = 'clear_all';
  static const String categories = 'categories';
  static const String brands = 'brands';
  static const String apply = 'apply';
  static const String thereAreNoItemsInThe = 'there_are_no_items_in_the';
  static const String openNowShops = 'open_now_shops';
  static const String newShops = 'new_shops';
  static const String profile = 'profile';
  static const String order = 'orders';
  static const String liked = 'liked';
  static const String products = 'products';
  static const String likedProducts = 'liked_products';
  static const String allStores = 'all_stores';
  static const String goToCheckout = 'go_to_checkout';
  static const String myOrder = 'my_order';
  static const String deleteAll = 'delete_all';
  static const String searchIn = 'in';
  static const String storeInfo = 'store_info';
  static const String storeDeliveryTimes = 'store_delivery_times';
  static const String saved = 'saved';
  static const String seeMore = 'see_more';
  static const String seeAll = 'see_all';
  static const String mostSoldProducts = 'most_sold_products';
  static const String discountProducts = 'discount_products';
  static const String writeComment = 'write_comment';
  static const String topSales = 'top_sales';
  static const String newProducts = 'new_products';
  static const String deliveryTimes = 'delivery_times';
  static const String store = 'store';
  static const String workingHours = 'working_hours';
  static const String deliveryRange = 'delivery_range';
  static const String phone = 'phone';

  static const String search = 'search';
  static const String checkYourNetworkConnection =
      'check_your_network_connection';
  static const String somethingWentWrongWithTheServer =
      'something_went_wrong_with_the_server';
  static const String totalProductPrice = 'total_product_price';
  static const String totalProductTax = 'total_product_tax';
  static const String totalShopTax = 'total_shop_tax';
  static const String deliveryFee = 'delivery_fee';
  static const String coupon = 'coupon';
  static const String totalAmount = 'total_amount';
  static const String shop = 'shop';
  static const String tax = 'total_tax';
  static const String totalPrice = 'total_price';

  static const String cancelOrder = 'cancel_order';
  static const String continueText = 'continue';
  static const String free = 'free';
  static const String productNote = 'product_note';
  static const String delivery = 'delivery';
  static const String deliveryAddress = 'delivery_address';
  static const String deliveryTime = 'delivery_time';
  static const String selectDeliveryDate = 'select_delivery_date';
  static const String noSearchResults = 'no_search_results';
  static const String banner = 'banner';
  static const String currencies = 'currencies';
  static const String profileSettings = 'profile_settings';
  static const String generalInfo = 'general_info';
  static const String firstname = 'firstname';
  static const String surname = 'surname';
  static const String gender = 'gender';
  static const String male = 'male';
  static const String female = 'female';
  static const String dateOfBirth = 'date_of_birth';
  static const String phoneNumber = 'phone_number';
  static const String cancel = 'cancel';
  static const String noInternetConnection = 'no_internet_connection';
  static const String resetPassword = 'reset_password';
  static const String confirmation = 'confirm';
  static const String confirmPassword = 'confirm_password';
  static const String shops = 'shops';
  static const String notFound = 'not_found';
  static const String emailNotVerifiedYet = 'email_not_verified_yet';
  static const String yes = 'yes';
  static const String emailIsNotValid = 'email_is_not_valid';

  static const String passwordShouldContainMinimum8Characters =
      'password_should_contain_minimum_8_characters';
  static const String phoneNumberIsNotValid = 'phone_number_is_not_valid';
  static const String confirmationCodeIsNotPresent =
      'confirmation_code_is_not_present';
  static const String confirmPasswordIsNotTheSame =
      'confirm_password_is_not_the_same';
  static const String errorWithUpdatingPassword =
      'error_with_updating_password';

  ///Added by Sinyage
  static const String searchApp = 'searchApp';
  static const String light = 'light';
  static const String dark = 'dark';
  static const String editAccount = 'editAccount';
  static const String changePassword = 'changePassword';
  static const String account = 'account';
  static const String water = 'water';
  static const String expire = 'expire';
  static const String benefits = 'benefits';
  static const String plan = 'Plan';
  static const String notify = 'notify';
  static const String stores = 'stores';
  static const String etaTimeDialog = 'ETAtime';
  static const String titleETA = 'U+2139_Estimated_Time_of_Arrival';
  static const String etaTime = '60';
  static const String eTA = 'ETA';

  static const String etaTimeDialog2 = 'ETAtime';
  static const String titleETA2 = 'U+2139_Estimated_Time_of_Arrival';
  static const String etaTime2 = '30_-_60_Min';
  static const String eTA2 = 'ETA';

  /// Added by Sinyage
  static const String introslide1 = 'intro_slide1';
  static const String introslide2 = 'intro_slide2';
  static const String introslide3 = 'intro_slide3';
  static const String introslide4 = 'intro_slide4';
  static const String introslide5 = 'intro_slide5';

  static const String introbriefslide1 = 'introbrief_slide1';
  static const String introbriefslide2 = 'introbrief_slide2';
  static const String introbriefslide3 = 'introbrief_slide3';
  static const String introbriefslide4 = 'introbrief_slide4';
  static const String introbriefslide5 = 'introbrief_slide5';

  static const String maintenanceTitle = 'maintenance_title';
  static const String maintenanceBrief = 'maintenance_brief';
  static const String hello = 'hello';
  static const String hey = 'hey';
  static const String there = 'there';
  static const String signedtext = 'signedtext';
  static const String signtext = 'signtext';
  static const String signtext2 = 'signtext2';
  static const String appName = 'juvo';
  static const String appMotto = 'motto';
  static const String payfast = 'payload_payfast';
  static const String flutterWave = 'payload_flutterwave';
  static const String paystack = 'payload_paystack';
  static const String paymentMethodPrefix = 'paymentMethod_';
  static const String isAd = 'isAd';
  static const String searchUser = 'searchUser';
  static const String thisFieldIsNotMinusOrZero = 'thisFieldIsNotMinusOrZero';
  static const String members = 'members';
  static const String thereAreNoPaymentTypesHere = 'thereAreNoPaymentTypesHere';
  static const String fillWallet = 'fillWallet';
  static const String mostRecentOrder = 'mostRecentOrder';
  static const String sale = 'sale';

  ////Review Text
  static const String veryBad = 'veryBad';
  static const String bad = 'bad';
  static const String notBad = 'notBad';
  static const String good = 'good';
  static const String veryGood = 'veryGood';
  static const String exceptional = 'exceptional';
  static const String km = 'km';
  static const String comingSoon = 'comingSoon';
  static const String featureNotAvailable = 'featureNotAvailable';
  static const String ok = 'ok';

  static const String returnHome = 'return.home';
  static const String paymentRejected = 'payment.rejected';
  static const String paymentSuccessful = 'payment.successful';
  static const String checkout = 'checkout';

  static const String congrats = 'congrats';
  static const String thankYouPurchase = 'thank.you.purchase';
  static const String yourOrderShipping = 'your.order.shipping';

  static const String enterEmailOrPhone = 'enterEmailOrPhone';

  static const String emailOrPhone = 'emailOrPhone';

  static const String enterValidEmailOrPhone = 'enterValidEmailOrPhone';

  static const String pleaseSelectUser = 'pleaseSelectUser';

  static const String shopping = 'you.are.shopping.at';

  static const String weAreDelivering = 'Note:.We.will.be.delivering.to.this.address';

  static const String usingDefaultLocation =
      'using_default_location,_set_address';

  static const String selectCard = 'select.card';

  static const String selectSavedCard = 'select.saved.card';

  static const String deleteSavedCard = 'delete.saved.card';

  static const String noSavedCard = 'no.saved.card';

  static const String payWithCard = 'pay.with.card';

  static const String completeCardDetails = 'complete.card.details';

  static const String payWithSavedCard = 'pay.with.saved.card';

  static const String payWithNewCard = 'pay.with.new.card';

  static const String useYourSavedCards = 'use.you.saved.cards';

  static const String payNow = 'pay.now';

  // NOTE: no `payment` constant here on purpose. orders_sdk declares
  // `payment` in its manifest tr_keys, and the composer injects every
  // SDK-declared key into the @sdk-tr-keys block above; keeping a copy here
  // too makes the composed file declare `payment` twice ("already declared
  // in this scope"). The installer's collision guard only dedupes SDK vs
  // SDK, not SDK vs base, so base must not shadow SDK-declared keys.

  static const String expires = 'expires';

  static const String stay = 'stay';

  static const String successfullyDeleted = 'successfully.Deleted';

  static const String delete = 'delete';

  static const String addNewCardDescription =
      'pay.with.card.to.save.it.for.future.orders';

  static const String cardWillBeSaved = 'your.card.will.be.saved.for.future.payments';

  static const String enterCardDirectly = 'enter.Card.Directly';

  static const String cardAddedSuccessfully = 'card.Added.Successfully';

  static const String useThisCard = 'use.This.Card';

  static const String cards = 'Saved.Cards';

  static const String addNewCard = 'add.New.Card';

  ///wallet sends
  static const String topUpWallet = 'top_up_wallet';
  static const String sendMoney = 'send_money';
  static const String enterAmount = 'enter_amount';
  static const String quickAmount = 'quick_amount';
  static const String topUpNow = 'top_up_now';
  static const String topUpInfo = 'top_up_info';
  static const String pleaseEnterValidAmount = 'please_enter_valid_amount';
  static const String topUpSuccessful = 'top_up_successful';
  static const String searchRecipient = 'search_recipient';
  static const String searchByPhoneOrEmail = 'search_by_phone_or_email';
  static const String noUsersFound = 'no_users_found';
  static const String pleaseSelectRecipient = 'please_select_recipient';
  static const String sendNow = 'send_now';
  static const String moneySentSuccessfully = 'money_sent_successfully';
  static const String topup = 'topup';
  static const String loan = 'loan';

  ///Driver
  static const String carSettings = "car.settings";
  static const String becomeDriver = "become.driver";
  static const String takePhoto = 'take.photo';
  static const String selectPhoto = 'select.photo';

  static const String cannotBeEmpty = 'cannot_be_empty';
  static const String height = 'height';
  static const String width = 'width';
  static const String length = 'length';
  static const String weight = 'weight';
  static const String foot = 'foot';
  static const String bike = 'bike';
  static const String motorbike = 'motorbike';
  static const String gas = 'gas';
  static const String note = 'note';
  static const String diesel = 'diesel';
  static const String benzine = 'benzine';
  static const String approve = 'approve';
  static const String accept = 'accept';
  static const String carPicture = 'car_picture';
  static const String color = 'color';
  static const String stateNumber = 'state_number';
  static const String carModels = 'car_models';
  static const String carBrand = 'car_brand';
  static const String typeTechnique = 'type_of_technique';
  static const String deliveryVehicle = 'delivery_vehicle';
  static const String yourName = 'your_name';
  static const String size = 'Size';
  static const String errorWithCreatingAccount = 'error_with_creating_account';

  static const String loans = 'loans';
  static const String saveForLater = 'Save.for.Later';
  static const String withdraw = 'withdraw';

  static const String daysInAppThisYear = 'daysInAppThisYear';
  // Dotted key so the humanized fallback reads "Days in app this week"
  // when neither the served map nor a bundled map carries a row.
  static const String daysInAppThisWeek = 'days.in.app.this.week';
  // Small-count variants for the AppUsageBadge: the singular row for
  // exactly one recorded day, and the sub-day copy shown instead of
  // "0 days in app ..." while no day has been recorded yet.
  static const String dayInAppThisYear = 'day.in.app.this.year';
  static const String dayInAppThisWeek = 'day.in.app.this.week';
  static const String lessThanADayInAppThisYear =
      'less.than.a.day.in.app.this.year';
  static const String lessThanADayInAppThisWeek =
      'less.than.a.day.in.app.this.week';
  static const String goodMorning = 'good.Morning';
  static const String goodAfternoon = 'goodAfternoon';
  static const String goodEvening = 'good.Evening';

  static const String period = 'period';
  static const String pause = 'pause';
  static const String resume = 'resume';
  static const String paymentMethod = 'payment_method';
  static const String ended = 'ended';
  static const String insufficientBalance = 'insufficient_balance';

  // Added during the 2026-07 refork: referenced by subscriptions_sdk /
  // productivity_sdk template pages that previously targeted the retired
  // core_sdk's TrKeys surface.
  static const String month = 'month';
  static const String youHaveSubscription = 'you.have.subscription';
  static const String withReport = 'with.report';
  static const String product = 'product';
  static const String subscriptions = 'subscriptions';
  static const String subscriptionIncludes = 'subscription.includes';
  static const String selectPayment = 'select.payment';
  static const String purchase = 'purchase';
  static const String productCount = 'product.count';
  static const String orderCount = 'order.count';
  static const String noData = 'no.data';
  static const String duration = 'duration';
  static const String selectTime = 'select.time';

  // --- Shared by the paas_manager and paas_driver forks (added 2026-08-02).
  // Hand-written here rather than declared in either SDK's manifest tr_keys:
  // the installer resolves a double declaration by silently keeping whichever
  // SDK it sees first, so keys two or more consumers need belong in base_sdk.
  // Values follow base_sdk's dominant convention (snake_case / lowercase,
  // 476 of 532), which is what paas_manager already used; where paas_driver's
  // local copy disagreed it was Title-Case display text - the outlier style
  // here at 7 of 532.
  static const String acceptedOrders = 'accepted_orders';
  static const String active = 'active';
  static const String addComment = 'add_comment';
  static const String amount = 'amount';
  static const String customerOrder = 'customer_order';
  static const String deletedUser = 'deleted.user';
  static const String deliveryZone = 'delivery_zone';
  static const String demoLoginPassword = 'demo_login_password';
  static const String doYouReallyWantToLogout = 'do_you_really_want_to_logout';
  static const String earningsChart = 'earnings_chart';
  static const String earningsRestaurant = 'earnings_of_the_restaurant';
  static const String editProduct = 'edit_product';
  static const String enterOpeningHours = 'enter_the_restaurant_opening_hours';
  static const String fm = 'fm';
  static const String foods = 'foods';
  static const String juvoBenefit = 'juvo_benefit';
  static const String inactiveTime = 'choose_inactive_meal_time';
  static const String income = 'income';
  static const String keepMeLoggedIn = 'keep_me_logged_in';
  static const String lastIncome = 'last_income';
  static const String lastname = 'lastname';
  static const String locationConfirmation = 'location_confirmation';
  static const String loginCredentialsAreNotValid = 'login_credentials_are_not_valid';
  static const String monthly = 'monthly';
  static const String moreOrders = 'more_details_about_all_orders';
  static const String myOrderHistory = 'my_order_history';
  static const String newOrders = 'new_orders';
  static const String noNotices = 'no_notices';
  static const String orderPrice = 'order_price';
  static const String ordering = 'ordering';
  static const String orders = 'orders';
  static const String overall = 'overall';
  static const String parameters = 'parameters';
  static const String passwordShouldContainMinimum6Characters = 'password_should_contain_minimum_6_characters';
  static const String rejectedOrders = 'rejected_orders';
  static const String restaurantSettings = 'restaurant_settings';
  static const String sections = 'sections';
  static const String selectDesiredOrderHistory = 'select_desired_order_history';
  static const String setBusinessDay = 'set_as_a_business_day';
  static const String settings = 'settings';
  static const String sideDish = 'side_dish';
  static const String smsDidntSend = 'sms_didnt_send';
  static const String statistics = 'statistics';
  static const String toBuy = 'to_buy';
  static const String totalOrders = 'total.orders';
  static const String userAlready = 'user.already';
  static const String weekly = 'weekly';
  static const String withdrawMoney = 'withdraw_money';
  static const String yourBenefit = 'your_benefit';
}
