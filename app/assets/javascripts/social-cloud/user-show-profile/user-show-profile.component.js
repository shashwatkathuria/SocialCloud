'use strict';

angular.
  module('userShowProfile').
  component('userShowProfile', {
    templateUrl: userShowProfileTemplateUrl,
    controller: function UserShowProfileController($scope, $location, $http, $window) {
        var vm = this;
        var requestUrl = $location.path();
        $http.get(requestUrl + "?format=json").then(function(response){
          vm.userProfile = response.data;
        }).catch(function(error){
          $window.location.href = '/';
        });

    }
  });
