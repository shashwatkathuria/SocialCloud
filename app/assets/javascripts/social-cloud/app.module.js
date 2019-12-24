'use strict';

angular.module('socialCloudApp', ['profileDetails', 'userSearchDetails', 'userShowProfile', 'postDetails', 'postSearchDetails', 'postShow'], function($locationProvider){
    $locationProvider.html5Mode({
      enabled: true,
      requireBase: false,
      rewriteLinks: false
    });
});

$(document).on('turbolinks:load', function() {
  return angular.bootstrap(document.body, ['socialCloudApp']);
});
