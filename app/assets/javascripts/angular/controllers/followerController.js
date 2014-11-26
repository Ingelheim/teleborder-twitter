var followerController = teleborderTwitterApp.controller('FollowerController', ['$scope', '$http', function($scope, $http) {

	$scope.twitterHandleA = undefined;
	$scope.twitterHandleB = undefined;
	$scope.loadingTweets = false;

	function showFollowersAndHideLoader(data) {
		$scope.followers = data;
		$scope.loadingFollowers = false;
	}

	$scope.getFollowers = function() {
		$scope.followers = undefined;
		if ($scope.twitterHandleA && $scope.twitterHandleB) {

			$scope.loadingFollowers = true;

			$http.get('/api/followers?twitterHandleA=' + $scope.twitterHandleA + '&twitterHandleB=' + $scope.twitterHandleB).
			success(function(data, status, headers, config) {
				showFollowersAndHideLoader(data);
			}).
			error(function(data, status, headers, config) {
				$scope.showError("There has been an error. Please try again");
			});
		} else {
			$scope.showError("Please enter a twitter handle to proceed");
		}
	}	
}]);