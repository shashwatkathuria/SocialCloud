'use strict';

angular.
  module('profileDetails').
  component('profileDetails', {
    templateUrl: profileDetailsTemplateUrl,
    controller: function ProfileDetailsController($scope, $http) {
        var vm = this;
        $http.get("/users?format=json").then(function(response){
          vm.profileInfo = response.data;
        });

    }
  });
