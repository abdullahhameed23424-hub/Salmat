
class DownloadState {}

class InitialState extends DownloadState{}

class UndefinedState extends DownloadState{}

class TaskNotFoundState extends DownloadState{}

class StartedState extends DownloadState{}

class QueuedState extends DownloadState{}

class RunningState extends DownloadState{}

class FailedState extends DownloadState{}

class CompleteState extends DownloadState{}

class CanceledState extends DownloadState{}
class CancellingSate extends DownloadState{}


class RetriedState extends DownloadState{}
class RetriedFailedState extends DownloadState{}
class RetryingState extends DownloadState{}

class RequestingState extends DownloadState{}
class RequestingFailedState extends DownloadState{}




