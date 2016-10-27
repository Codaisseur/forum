document.addEventListener("turbolinks:load", function() {
    $('.q-edit-btn').click(function() {
        var id = $(this).attr('id');
        $('#question-' + id).toggle();
        $('#form-' + id).toggle();
    });


    $('.save-edit').click(function() {
        var question_id = $(this).attr('question_id');
        var body = $('#form-' + question_id + ' .edit-body').val();

        $.ajax({
            url: '/questions/' + question_id,
            type: 'PUT',
            dataType: "json",
            data: {
                'body': body
            },
            success: function(response) {
                $('#question-' + question_id).html(response.body).show();
                $('#form-' + question_id).hide();

            },
            error: function(response) {
                console.log(response);
            }
        });
    });
});


$(document).ready(function() {
  $('#subscribe-checkbox').change(function() {
      var wants_email = this.checked
      var question_id = $(this).attr('name');
      console.log(question_id);

      $.ajax({
          url: '/questions/subscribe',
          type: 'GET',
          dataType: "json",
          data: {'subscribe': wants_email, 'question_id': question_id},
          success: function(response) {
              console.log('YAY!');
          },
          error: function(response) {
              console.log(response);
          }
      });
    });
});
