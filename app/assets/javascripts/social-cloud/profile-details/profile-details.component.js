'use strict';

angular.
  module('profileDetails').
  component('profileDetails', {
    templateUrl: profileDetailsTemplateUrl,
    controller: ProfileDetailsController
  });

ProfileDetailsController.$inject = ['$scope', '$http', '$location'];

function ProfileDetailsController($scope, $http, $location) {
    var vm = this;
    var requestUrl = $location.path();
    $http.get(requestUrl + "?format=json").then(function(response){
      vm.profileInfo = response.data;
    });

}
