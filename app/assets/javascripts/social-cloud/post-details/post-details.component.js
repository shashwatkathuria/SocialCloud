'use strict';

angular.
  module('postDetails').
  component('postDetails', {
    templateUrl: postDetailsTemplateUrl,
    controller: PostDetailsController
  });

PostDetailsController.$inject = ['$scope', '$http', '$location'];

function PostDetailsController($scope, $http, $location) {
    var vm = this;
    var requestUrl = $location.path();
    $http.get(requestUrl + "?format=json").then(function(response){
      vm.postsInfo = response.data;
    });
    $scope.deleteWarning = function(event){
      if (confirm("Are you sure you want to delete the post?")) {
          // Do nothing
      } else {
          event.preventDefault();
      }
    };

}
