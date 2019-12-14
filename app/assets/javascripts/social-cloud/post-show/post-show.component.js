'use strict';

angular.
  module('postShow').
  component('postShow', {
    templateUrl: postShowTemplateUrl,
    controller: function PostShowDetailsController($scope, $http, $location) {
        var vm = this;
        var requestUrl = $location.path();
        $http.get(requestUrl + "?format=json").then(function(response){
          vm.post = response.data;
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
