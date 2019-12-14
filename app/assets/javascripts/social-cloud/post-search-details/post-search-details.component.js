'use strict';

angular.
  module('postSearchDetails').
  component('postSearchDetails', {
    templateUrl: postSearchDetailsTemplateUrl,
    controller: function PostSearchDetailsController($scope, $http, $location) {
        var vm = this;
        var requestUrl = $location.path();
        $http.get(requestUrl + "?format=json").then(function(response){
          vm.searchResults = response.data;
        });
        $scope.deleteWarning = function(event){
          if (confirm("Are you sure you want to delete the post?")) {
              // Do nothing
          } else {
              event.preventDefault();
          }
        };

    }
  });
