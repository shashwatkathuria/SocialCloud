'use strict';

angular.module('socialCloudApp', ['profileDetails', 'userSearchDetails', 'userShowProfile', 'postDetails', 'postSearchDetails', 'postShow'], function($locationProvider){
    $locationProvider.html5Mode({
      enabled: true,
      requireBase: false,
      rewriteLinks: false
    });
});

$(document).ready(function() {
  angular.bootstrap(document.body, ['socialCloudApp']);
});
