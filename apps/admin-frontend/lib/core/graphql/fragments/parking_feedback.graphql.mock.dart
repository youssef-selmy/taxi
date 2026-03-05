import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingFeedbackParameter1 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Cleanliness",
  isGood: true,
);

final mockParkingFeedbackParameter2 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Price",
  isGood: false,
);

final mockParkingFeedbackParameter3 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Location",
  isGood: true,
);

final mockParkingFeedbackParameter4 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Service",
  isGood: false,
);

final mockParkingFeedbackParameter5 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Security",
  isGood: true,
);

final mockParkingFeedbackParameter6 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Availability",
  isGood: false,
);

final mockParkingFeedbackParameter7 = Fragment$parkingFeedbackParameter(
  id: "1",
  name: "Size",
  isGood: true,
);

final mockParkingFeedback1 = Fragment$parkingFeedback(
  id: "1",
  score: 90,
  comment: "Good",
  status: Enum$ReviewStatus.Pending,
  order: Fragment$parkingFeedback$order(
    id: "1",
    parkSpot: mockParkingCompact1,
    vehicleType: Enum$ParkSpotVehicleType.Car,
    carOwner: mockCustomerCompact1,
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  parameters: [
    mockParkingFeedbackParameter1,
    mockParkingFeedbackParameter2,
    mockParkingFeedbackParameter3,
    mockParkingFeedbackParameter4,
    mockParkingFeedbackParameter5,
  ],
);

final mockParkingFeedback2 = Fragment$parkingFeedback(
  id: "2",
  score: 70,
  comment: "Bad",
  status: Enum$ReviewStatus.Approved,
  order: Fragment$parkingFeedback$order(
    id: "1",
    parkSpot: mockParkingCompact1,
    vehicleType: Enum$ParkSpotVehicleType.Car,
    carOwner: mockCustomerCompact1,
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  parameters: [
    mockParkingFeedbackParameter1,
    mockParkingFeedbackParameter2,
    mockParkingFeedbackParameter6,
    mockParkingFeedbackParameter7,
    mockParkingFeedbackParameter5,
  ],
);

final mockParkingFeedback3 = Fragment$parkingFeedback(
  id: "3",
  score: 80,
  comment: "Good",
  status: Enum$ReviewStatus.Rejected,
  order: Fragment$parkingFeedback$order(
    id: "1",
    parkSpot: mockParkingCompact1,
    vehicleType: Enum$ParkSpotVehicleType.Car,
    carOwner: mockCustomerCompact1,
  ),
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
  parameters: [
    mockParkingFeedbackParameter1,
    mockParkingFeedbackParameter5,
    mockParkingFeedbackParameter3,
    mockParkingFeedbackParameter7,
    mockParkingFeedbackParameter2,
  ],
);

final mockParkingFeedbacks = [
  mockParkingFeedback1,
  mockParkingFeedback2,
  mockParkingFeedback3,
];

final mockParkingReviewParameterListItem1 =
    Fragment$parkingFeedbackParameterListItem(
      id: "1",
      name: "Cleanliness",
      isGood: true,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItem2 =
    Fragment$parkingFeedbackParameterListItem(
      id: "2",
      name: "Price",
      isGood: false,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItem3 =
    Fragment$parkingFeedbackParameterListItem(
      id: "3",
      name: "Location",
      isGood: true,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItem4 =
    Fragment$parkingFeedbackParameterListItem(
      id: "4",
      name: "Service",
      isGood: false,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItem5 =
    Fragment$parkingFeedbackParameterListItem(
      id: "5",
      name: "Security",
      isGood: true,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItem6 =
    Fragment$parkingFeedbackParameterListItem(
      id: "6",
      name: "Availability",
      isGood: false,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItem7 =
    Fragment$parkingFeedbackParameterListItem(
      id: "7",
      name: "Size",
      isGood: true,
      feedbacksAggregate: [
        Fragment$parkingFeedbackParameterListItem$feedbacksAggregate(
          count:
              Fragment$parkingFeedbackParameterListItem$feedbacksAggregate$count(
                id: 1,
              ),
        ),
      ],
    );

final mockParkingReviewParameterListItems = [
  mockParkingReviewParameterListItem1,
  mockParkingReviewParameterListItem2,
  mockParkingReviewParameterListItem3,
  mockParkingReviewParameterListItem4,
  mockParkingReviewParameterListItem5,
  mockParkingReviewParameterListItem6,
  mockParkingReviewParameterListItem7,
];
