$(document).ready( function() {

$('#submit').on('click', function() {
    $('#favorite_food').val('');
    $('#name').val('');
    $('#submit').addClass('disabled');
    $('#submit').prop('disabled', true);
});

});
