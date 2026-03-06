/// This enum is used to indicate a user's current availability status.
///
/// - `busy`: The user is unavailable. Red and useful for Blocked or indefinite unavailabnility state.
/// - `away`: The user is away from their device. Orange and useful for momentary unavailabnility.
/// - `online`: The user is online and available.
/// - `offline`: The user is offline and unavailable.
enum StatusBadgeType { none, busy, away, online, offline }
