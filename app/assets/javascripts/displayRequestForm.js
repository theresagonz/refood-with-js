$(document).on('turbolinks:load', () => {
  $('#show-request-form').on('click', e => {
    e.preventDefault();
    $('#show-request-form').empty();
    $('#show-request-form').append('<h3>New request</h3>')

    const id = parseInt($('.js-next').attr('data-id'), 10);
    console.log('id', id)
    const formContent = `
    <form id="request-form" action="/offers/${id}/requests" method="POST">
      <div class="form-group">
        <label for="request-message">Message</label>
        <input type="text" id="request-message" class="form-control">
      </div>
      <p><b>Contact me at (at least one is required):</b></p>
      <div class="form-group">
        <label for="requestor-email">Email</label>
        <input type="text" id="requestor-email" class="form-control">
      </div>
      <div class="form-group">
        <label for="requestor-phone">Phone</label>
        <input type="text" id="requestor-phone" class="form-control">
      </div>
      <input type="submit" class="btn btn-primary">
      <a href="/index" class="btn btn-secondary">Cancel</a>
    </form>
    `;

    $('#place-for-request-form').html(formContent);
  });
});
