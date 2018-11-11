$(() => {
  $('#show-request-form').on('click', e => {
    e.preventDefault();
    const id = parseInt($('.js-next').attr('data-id'), 10);

    const formContent = `
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
    `;

    $('#request-form').html(formContent);
  });
});
