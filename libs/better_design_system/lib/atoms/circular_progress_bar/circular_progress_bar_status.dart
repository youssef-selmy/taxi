/// Enum representing the different statuses of a circular progress bar.
///
/// - [pending]: The progress bar is in a pending state (e.g., the process has not started yet).
/// - [uploading]: The progress bar indicates that a process is in progress (e.g., data is being uploaded).
/// - [error]: The progress bar shows an error state (e.g., the process failed).
/// - [success]: The progress bar indicates that the process was successful (e.g., the task completed).
enum CircularProgressBarStatus { pending, uploading, error, success }
