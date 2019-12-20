'use strict';

angular.
  module('userShowProfile').
  component('userShowProfile', {
    templateUrl: userShowProfileTemplateUrl,
    controller: function UserShowProfileController($scope, $location, $http) {
        var vm = this;
        var requestUrl = $location.path();
        console.log(requestUrl);
        $http.get(requestUrl + "?format=json").then(function(response){
          vm.userProfile = response.data;
        });

    }
  });
