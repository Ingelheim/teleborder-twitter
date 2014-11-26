var mainController = teleborderTwitterApp.controller('MainController', ['$rootScope', '$scope', '$timeout', function ($rootScope, $scope, $timeout) {

  $rootScope.tweets = true;
  $rootScope.follower = false;

  $scope.goToTweets = function () {
    $rootScope.tweets = true;
    $rootScope.follower = false;
  }

  $scope.goToFollower = function () {
    $rootScope.tweets = false;
    $rootScope.follower = true;
  }

  $scope.showError = function (message) {
    $scope.errorMessage = message;

    $timeout(function () {
      $scope.errorMessage = undefined;
    }, 3000);
  }
}]);
