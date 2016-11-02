// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree .
//= require moment
//= require turbolinks


// var datetime;
//
// var update = function () {
//     $.each(datetime, function(key, value) {
//         diffTime = calculateDiff($(value).data('start-time'));
//
//         $(value).html(diffTime);
//     });
// };
//
// var calculateDiff = function(startDate) {
//     date      = moment(new Date());
//     startDate = moment(startDate);
//
//     date     = date.diff(startDate);
//     diffTime = moment.duration(date);
//
//     hours   = diffTime.hours();
//     minutes = diffTime.minutes();
//     seconds = diffTime.seconds();
//
//     if (hours < 10) {
//         hours = '0' + hours;
//     }
//     if (minutes < 10) {
//         minutes = '0' + minutes;
//     }
//     if (seconds < 10) {
//         seconds = '0' + seconds;
//     }
//
//     return hours + ':' + minutes + ':' + seconds;
// }
//
// $(function(){
//     datetime = $('.js-entry-time-ellapsed');
//
//     update();
//     setInterval(update, 1000);
// });
