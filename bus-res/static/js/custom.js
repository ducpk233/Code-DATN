/*
Template Name: OsahanBus - Bus Booking HTML Mobile Template
Author: Askbootstrap
Author URI: https://themeforest.net/user/askbootstrap
Version: 0.1
*/

(function($) {
    "use strict"; // Start of use strict

    // Tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Osahan Slider
    $('.osahan-slider').slick({
        infinite: true,
        autoplay: true,
        autoplaySpeed: 2500,
        centerMode: false,
        slidesToShow: 1,
        arrows: false,
        dots: true
    });

    // Sidebar Nav
    var $main_nav = $('#main-nav');
    var $toggle = $('.toggle');

    var defaultOptions = {
        disableAt: false,
        customToggle: $toggle,
        levelSpacing: 40,
        navTitle: '',
        levelTitles: true,
        levelTitleAsBack: true,
        pushContent: '#container',
        insertClose: 2
    };

    // call our plugin
    var Nav = $main_nav.hcOffcanvasNav(defaultOptions);

    // Select2
    $('.js-example-basic-single').select2();
    
     
    

})(jQuery); // End of use strict
    