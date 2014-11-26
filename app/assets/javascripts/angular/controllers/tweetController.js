var tweetController = teleborderTwitterApp.controller('TweetController', ['$scope', '$http', function($scope, $http) {

  $scope.twitterHandle = undefined;
  $scope.loadingFollowers = false;

  function showTweetsAndHideLoader(data) {
    $scope.userTweets = data;
    $scope.loadingTweets = false;
  }

  $scope.getTweets = function() {
    $scope.userTweets = undefined;
    
    if ($scope.twitterHandle) {

      $scope.loadingTweets = true;

      $http.get('/api/tweets?twitterHandle='+ $scope.twitterHandle).
      success(function(data, status, headers, config) {
        showTweetsAndHideLoader(data.tweets);
      }).
      error(function(data, status, headers, config) {
        $scope.showError("There has been an error. Please try again");
      });
    } else {
      $scope.showError("Please enter a twitter handle to proceed");
    }
  }	
}]);