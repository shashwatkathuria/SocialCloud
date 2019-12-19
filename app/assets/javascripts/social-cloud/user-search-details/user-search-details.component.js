'use strict';

angular.
  module('userSearchDetails').
  component('userSearchDetails', {
    templateUrl: userSearchDetailsTemplateUrl,
    controller: function UserSearchDetailsController($scope, $location, $http) {
        var vm = this;
        var requestUrl = $location.path();
        $http.get(requestUrl + "?format=json").then(function(response){
          vm.searchResults = response.data;
        });

    }
  });
